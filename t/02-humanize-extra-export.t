#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 10;

use List::ToHumanString qw/to_human_string  h  humanize/;

is(
    to_human_string(),
    h(),
    q{Humanize zero items with h()},
);

is(
    to_human_string(qw/foo/),
    h(qw/foo/),
    q{Humanize one item with h()},
);

is(
    to_human_string(qw/foo bar/),
    h(qw/foo bar/),
    q{Humanize two items with h()},
);

is(
    to_human_string(qw/foo bar baz/),
    h(qw/foo bar baz/),
    q{Humanize three items with h()},
);

is(
    to_human_string(qw/foo bar baz ber/),
    h(qw/foo bar baz ber/),
    q{Humanize four items with h()},
);


is(
    to_human_string(),
    humanize(),
    q{Humanize zero items with humanize()},
);

is(
    to_human_string(qw/foo/),
    humanize(qw/foo/),
    q{Humanize one item with humanize()},
);

is(
    to_human_string(qw/foo bar/),
    humanize(qw/foo bar/),
    q{Humanize two items with humanize()},
);

is(
    to_human_string(qw/foo bar baz/),
    humanize(qw/foo bar baz/),
    q{Humanize three items with humanize()},
);

is(
    to_human_string(qw/foo bar baz ber/),
    humanize(qw/foo bar baz ber/),
    q{Humanize four items with humanize()},
);


