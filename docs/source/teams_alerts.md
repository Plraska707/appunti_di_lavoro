# Configurazione Alert Teams per Airflow

## Scopo

Inviare una notifica automatica su **Microsoft Teams** quando una task **Apache Airflow** entra nello stato **FAILED**.

L'integrazione utilizza:

- Apache Airflow
- Microsoft Teams
- Power Automate Workflow (Webhook)
- Adaptive Cards

---

## Architettura

```text
Airflow Task Failure
          |
          v
on_failure_callback
          |
          v
HTTP POST verso Webhook Teams
          |
          v
Power Automate Workflow
("Send webhook alerts to Airflow_alerts")
          |
          v
Pubblicazione Adaptive Card
nel canale Teams Airflow_alerts
```

---

## Configurazione Teams

### Workflow utilizzato

Nel canale Teams è stato creato il workflow:

```text
Send webhook alerts to Airflow_alerts
```

Il workflow genera un endpoint HTTP (webhook) che riceve richieste POST e pubblica una **Adaptive Card** nel canale.

#### Nota importante

Il workflow si aspetta che il body della richiesta sia direttamente una **Adaptive Card** valida.

**Non è supportato** il formato:

```json
{
  "type": "message",
  "attachments": []
}
```

Il payload deve iniziare con:

```json
{
  "type": "AdaptiveCard",
  "$schema": "http://adaptivecards.io/schemas/adaptive-card.json"
}
```

---

## Configurazione Airflow

### Variabile Airflow

È stata creata la variabile:

```text
teams_webhook_url
```

contenente l'URL del webhook generato dal workflow Teams.

#### Verifica da CLI

```bash
airflow variables get teams_webhook_url
```

#### Verifica da UI

```text
Admin
→ Variables
→ teams_webhook_url
```

---

## Callback Python

#### File

```text
dags/tasks/alert_callback.py
```

#### Contenuto

```python
from airflow.models import Variable
import requests
import logging

TEAMS_WEBHOOK_URL = Variable.get("teams_webhook_url")


def teams_failure_callback(context):

    dag_id = context["dag"].dag_id
    ti = context["task_instance"]

    task_id = ti.task_id
    run_id = context.get("run_id", "N/A")
    log_url = getattr(ti, "log_url", "")
    exception = str(context.get("exception", "Unknown error"))

    payload = {
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "type": "AdaptiveCard",
        "version": "1.4",
        "body": [
            {
                "type": "TextBlock",
                "text": "❌ Airflow Task Failed",
                "weight": "Bolder",
                "size": "Large",
                "color": "Attention"
            },
            {
                "type": "FactSet",
                "facts": [
                    {
                        "title": "DAG",
                        "value": dag_id
                    },
                    {
                        "title": "Task",
                        "value": task_id
                    },
                    {
                        "title": "Run ID",
                        "value": run_id
                    }
                ]
            },
            {
                "type": "TextBlock",
                "text": f"Error: {exception}",
                "wrap": True
            }
        ]
    }

    if log_url:
        payload["actions"] = [
            {
                "type": "Action.OpenUrl",
                "title": "Open Airflow Logs",
                "url": log_url
            }
        ]

    try:
        response = requests.post(
            TEAMS_WEBHOOK_URL,
            json=payload,
            timeout=10
        )

        response.raise_for_status()

        logging.info(
            "Teams 