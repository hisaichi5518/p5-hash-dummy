package Hash::Dummy::Type::Str;
use strict;
use warnings;

sub create_value {
    my ($class, $args) = @_;

    my $size  = $args->{size} || 15;
    my @array = @{$args->{array}};

    my $result;
    for (1..$size) {
        $result .= $array[int rand(scalar @array)];
    }

    $result;
}

1;
