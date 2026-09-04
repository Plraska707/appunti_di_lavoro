:orphan:

# Ticket Created

Your ticket has been created successfully.

<div id="ticket-info"></div>

<p>
    <button onclick="window.location.href='support.html'">
        Create Another Ticket
    </button>
</p>

<script>
const params = new URLSearchParams(window.location.search);
const ticket = params.get("ticket");

if (ticket) {
    document.getElementById("ticket-info").innerHTML =
        "<p><strong>Ticket ID:</strong> " + ticket + "</p>";
}
</script>
