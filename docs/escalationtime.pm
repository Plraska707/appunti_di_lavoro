use DateTime;

sub next_business_day {
    my ($dt) = @_;

    $dt = $dt->clone->add(days => 1);

    while ($dt->day_of_week > 5) {
        $dt->add(days => 1);
    }

    return $dt;
}

my $ticket = $self->TicketObj;

my $created = DateTime->from_epoch(
    epoch     => $ticket->CreatedObj->Unix,
    time_zone => 'Europe/Rome',
);

my $effective = $created->clone;

# Weekend => next Monday
while ($effective->day_of_week > 5) {
    $effective->add(days => 1);
}

# After 18:30 => next business day
if (
       $effective->hour > 18
    || ($effective->hour == 18 && $effective->minute >= 30)
) {
    $effective = next_business_day($effective);
}

# Escalate on next business day at 18:30
my $escalate = next_business_day($effective);

$escalate->set(
    hour   => 18,
    minute => 30,
    second => 0,
);

$ticket->AddCustomFieldValue(
    Field => 'EscalateAt',
    Value => $escalate->strftime('%Y-%m-%d %H:%M:%S'),
);

return 1;