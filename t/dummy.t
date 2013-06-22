use strict;
use warnings;
use utf8;
use Test::More;
use Hash::Dummy qw(create_dummy_hash);

subtest "create_dummy_hash" => sub {
    my %hash = create_dummy_hash(
        str => {
            type  => "Str",
            array => ["あ".."ん"],
            size  => 5,
        },
        int => {
            type  => "Int",
            array => [1..15],
        },
        default => "default value"
    );

    is length $hash{str}, 5;
    cmp_ok $hash{int}, "<", 16;
    cmp_ok $hash{int}, ">", 0;
    is $hash{default}, "default value";
};

done_testing;
