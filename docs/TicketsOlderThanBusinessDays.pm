package RT::Search::TicketsOlderThanBusinessDays;
use base 'RT::Search::FromSQL';
use strict;
use warnings;
use RT::Date;

# Festività nazionali italiane (fisse + mobili per 2026-2027)
my @national_holidays = (
    # 2026
    '2026-01-01',  # Capodanno
    '2026-01-06',  # Epifania
    '2026-04-05',  # Pasqua
    '2026-04-06',  # Lunedì dell'Angelo
    '2026-04-25',  # Festa della Liberazione
    '2026-05-01',  # Festa dei Lavoratori
    '2026-06-02',  # Festa della Repubblica
    '2026-08-15',  # Ferragosto
    '2026-10-04',  # San Francesco
    '2026-11-01',  # Ognissanti
    '2026-12-08',  # Immacolata
    '2026-12-25',  # Natale
    '2026-12-26',  # Santo Stefano
    # 2027
    '2027-01-01',  # Capodanno
    '2027-01-06',  # Epifania
    '2027-04-04',  # Pasqua
    '2027-04-05',  # Lunedì dell'Angelo
    '2027-04-25',  # Festa della Liberazione
    '2027-05-01',  # Festa dei Lavoratori
    '2027-06-02',  # Festa della Repubblica
    '2027-08-15',  # Ferragosto
    '2027-11-01',  # Ognissanti
    '2027-12-08',  # Immacolata
    '2027-12-25',  # Natale
    '2027-12-26',  # Santo Stefano
);

# Business hours
use constant BUSINESS_HOUR_START => 8;
use constant BUSINESS_HOUR_END   => 18;
use constant BUSINESS_MINUTE_START => 30;

sub Describe {
    return "Find tickets older than N business days in a queue";
}

sub Prepare {
    my $self = shift;
    my %args = (
        Queue => '',
        BusinessDays => 2,
        Status => ['new', 'open'],
        @_
    );
    
    $self->{'queue'} = $args{Queue};
    $self->{'business_days'} = $args{BusinessDays};
    $self->{'statuses'} = $args{Status};
    
    return 1;
}

sub FindTickets {
    my $self = shift;
    my $tickets = RT::Tickets->new($RT::SystemUser);
    
    my @status_clause = map { "'$_'" } @{$self->{'statuses'}};
    my $status_sql = join(',', @status_clause);
    
    $tickets->Limit(
        FIELD => 'Queue',
        VALUE => $self->{'queue'},
    );
    $tickets->Limit(
        FIELD => 'Status',
        OPERATOR => 'IN',
        VALUE => "($status_sql)",
    );
    
    my $now = RT::Date->new($RT::SystemUser);
    $now->SetToNow;
    
    while (my $ticket = $tickets->Next) {
        my $created = $ticket->CreatedObj;
        my $deadline = $self->_add_business_days_with_time($created, $self->{'business_days'}, 20);
        
        if ($now->Unix >= $deadline->Unix) {
            $self->AddId($ticket->Id);
        }
    }
    
    return 1;
}

sub _is_business_day {
    my $self = shift;
    my ($date) = @_;
    
    my $dow = $date->DayOfWeek;
    my $date_str = sprintf('%04d-%02d-%02d', $date->Year, $date->Month, $date->Day);
    
    # Weekend: 0 = Domenica, 6 = Sabato
    return 0 if ($dow == 0 || $dow == 6);
    
    # Festività nazionali
    return 0 if grep { $_ eq $date_str } @national_holidays;
    
    return 1;
}

sub _is_business_hours {
    my $self = shift;
    my ($date) = @_;
    
    my $hour = $date->Hour;
    my $minute = $date->Minute;
    
    # time < 18:30 → conta come business day
    # time >= 18:30 → NON conta
    if ($hour >= BUSINESS_HOUR_END && $minute >= BUSINESS_MINUTE_START) {
        return 0;
    } elsif ($hour >= BUSINESS_HOUR_END) {
        return 0;
    }
    
    return 1;
}

sub _add_business_days_with_time {
    my $self = shift;
    my ($start, $days, $target_hour) = @_;
    
    my $result = $start->Clone;
    my $count = 0;
    
    # Controlla se il giorno di creazione è un business day
    if ($self->_is_business_day($start)) {
        # Controlla se è dentro o fuori business hours
        if ($self->_is_business_hours($start)) {
            # Dentro business hours (< 18:30): conta come BD 1
            $count = 1;
        } else {
            # Fuori business hours (>= 18:30): non conta, BD 1 = prossimo business day
            # Avanza al prossimo giorno
            $result->AddDays(1);
        }
    } else {
        # Weekend o festività: non conta, BD 1 = prossimo business day
        $result->AddDays(1);
    }
    
    # Se abbiamo già raggiunto i giorni richiesti
    if ($count >= $days) {
        $result->Set(
            Year => $result->Year,
            Month => $result->Month,
            Day => $result->Day,
            Hour => $target_hour,
            Minute => 0,
            Second => 0,
        );
        return $result;
    }
    
    # Altrimenti avanza fino a raggiungere N business days
    while ($count < $days) {
        if ($self->_is_business_day($result)) {
            $count++;
        }
        if ($count < $days) {
            $result->AddDays(1);
        }
    }
    
    # Imposta l'orario alle 20:00
    $result->Set(
        Year => $result->Year,
        Month => $result->Month,
        Day => $result->Day,
        Hour => $target_hour,
        Minute => 0,
        Second => 0,
    );
    
    return $result;
}

1;