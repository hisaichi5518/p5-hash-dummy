package Hash::Dummy::Type::Int;
use strict;
use warnings;

sub create_value {
    my ($class, $args) = @_;
    my @array = @{$args->{array}};
    $array[int rand(scalar @array)];
}

1;
