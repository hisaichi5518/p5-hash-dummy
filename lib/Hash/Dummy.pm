package Hash::Dummy;
use 5.008005;
use strict;
use warnings;
use parent "Exporter";

our $VERSION = "0.01";
our @EXPORT  = qw(create_dummy_hash);

# copeid Plack::Util::load_class()
sub _load_class {
    my($class, $prefix) = @_;

    if ($prefix) {
        unless ($class =~ s/^\+// || $class =~ /^$prefix/) {
            $class = "$prefix\::$class";
        }
    }

    my $file = $class;
    $file =~ s!::!/!g;
    require "$file.pm"; ## no critic

    return $class;
}

sub create_dummy_hash {
    my (%args) = @_;
    my %result;
    for my $key (keys %args) {
        my $val = $args{$key};

        if (!ref $val) {
            $result{$key} = $val;
            next;
        }

        my $type = $val->{type};
        my $klass = _load_class($type, "Hash::Dummy::Type");
        $result{$key} = $klass->create_value($val);
    }

    return %result;
}


1;
__END__

=encoding utf-8

=head1 NAME

Hash::Dummy - create dummy hash

=head1 SYNOPSIS

    use Hash::Dummy qw(create_dummy);

    my %hash = create_dummy_hash(
        id   => {
            type  => "Int",
            array => [1..150],
        },
        name => {
            type  => "Hiragana",
            size  => 15,
            array => ["あ".."ん", "a".."z", "A".."Z", 0..9],
        },
        nick => "hisaichi5518",
    );

=head1 DESCRIPTION

Hash::Dummy create dummy hash.

=head1 FUNCTIONS

=head2 C<< create_dummy_hash(%hash) >>

    my %hash = create_dummy_hash(
        id   => {
            type  => "Int",
            array => [1..150],
        },
        name => {
            type  => "Str",
            size  => 15,
            array => ["あ".."ん", "a".."z", "A".."Z", 0..9],
        },
        nick => "hisaichi5518",
    );

    use Data::Dumper;
    warn Dumper %hash

=head1 LICENSE

Copyright (C) hisaichi5518.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

hisaichi5518 E<lt>hisaichi5518@gmail.comE<gt>

=cut

