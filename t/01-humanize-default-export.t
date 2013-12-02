#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 7;

use List::ToHumanString;

is(
    to_human_string(),
    '',
    q{Humanize zero items},
);

is(
    to_human_string(qw/foo/),
    'foo',
    q{Humanize one item},
);

is(
    to_human_string(qw/foo bar/, undef, ''),
    'foo and bar',
    q{Humanize two items},
);

is(
    to_human_string(qw/foo bar baz/, undef, ''),
    'foo, bar, and baz',
    q{Humanize three items},
);

is(
    to_human_string(qw/foo bar/, undef, '', ' ', "\t",
    qw/baz ber/, undef, ''),
    'foo, bar, baz, and ber',
    q{Humanize four items},
);

eval {humanize(qw/foo bar baz/);};
ok( $@, q{humanize() isn't exported by default} );

eval {h(qw/foo bar baz/);};
ok( $@, q{h() isn't exported by default} );




