package List::ToHumanString;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.001';
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT    = qw(to_human_string);
our @EXPORT_OK = qw(humanize  h);
our $Extra_Comma  = 1;

sub to_human_string {
    my @list = @_;
    
    @list = grep defined, @list;

    if ( not @list ) {
        return '';
    }
    elsif ( @list == 1 ) {
        return "$list[0]";
    }
    elsif ( @list == 2 ) {
        return "$list[0]" . ' and ' . "$list[1]";
    }
    else {
        return join ', ', map "$_",
            $Extra_Comma
            ? ( @list[0..$#list-1], 'and ' . $list[-1] )
            : ( @list[0..$#list-2], $list[-2] . ' and ' . $list[-1] )
    }
}

sub humanize {
    to_human_string(@_);
}

sub h {
    to_human_string(@_);
}

1;

__END__

=encoding utf8

=head1 NAME

List::ToHumanString - write lists in strings like a human would

=head1 SYNOPSIS

    use List::ToHumanString;
    
    printf "Report(s) for %s.\n", to_human_string qw/March May June August/;
    ## prints: Report(s) for March, May, June, and August.
    
    printf "Report(s) for %s.\n", to_human_string qw/March May/;
    ## prints: Report(s) for March and May.
    
    printf "Report(s) for %s.\n", to_human_string qw/March/;
    ## prints: Report(s) for March.

    
    # Exact same thing, but with less typing, by exporting humanize or even h
    use List::ToHumanString qw/h humanize/;
    
    printf "Report(s) for %s.\n", humanize qw/March May June August/;
    ## prints: Report(s) for March, May, June, and August.
    
    printf "Report(s) for %s.\n", h qw/March May/;
    ## prints: Report(s) for March and May.
    
    
    # You can also use a simple ref-deref trick to interpolate the
    # results inside the strings:
    my $output = "Report(s) for ${\ to_human_string @items }.\n";
    
=head1 EXPORTS BY DEFAULT
    
=head2 C<to_human_string>

    use List::ToHumanString;
    
    printf "Report(s) for %s.\n", to_human_string qw/March May June August/;
    ## prints: Report(s) for March, May, June, and August.  
    
B<Exported by default>. B<Takes> a list of items as an argument.
B<REMOVES ALL UNDEFS>, then B<returns> a string.
The string format will be as follows (number of arguments below is the
number of arguments AFTER all undefs have been removed):

=head3 empty list as argument

    to_human_string();
    # returns ''

Returns empty string.

=head3 1-item list as argument

    to_human_string('foo');
    # returns 'foo'
    
    to_human_string( URI->new("http://example.com") );
    # returns 'http://example.com'

Returns the argument (stringified).

=head3 2-item list as argument

    to_human_string('foo', 'bar');
    # returns 'foo and bar'

Returns the two arguments joined with C<' and '>

=head3 list with 3 or more items as argument

    to_human_string('foo', 'bar', 'ber', 'baz');
    # returns 'foo, bar, ber, and baz'
    
    $List::ToHumanString::Extra_Comma = 0;
    to_human_string('foo', 'bar', 'ber', 'baz');
    # returns 'foo, bar, ber and baz'

Returns a string with arguments joined with C<', '> (comma and space).
The last element is also preceeded by word C<'and '>. B<Note:> depending
on your stylistic preference, you might wish not to have a comma before
the last element. You can accomplish that by setting 
C<$List::ToHumanString::Extra_Comma> to zero.

=head1 OPTIONAL EXPORTS

    use List::ToHumanString qw/h humanize/;
    
    printf "Report(s) for %s.\n", humanize qw/March May June August/;
    ## prints: Report(s) for March, May, June, and August.
    
    printf "Report(s) for %s.\n", h qw/March May/;
    ## prints: Report(s) for March and May.
    
=head2 C<humanize>

    printf "Report(s) for %s.\n", humanize qw/March May June August/;
    
You can optionally import C<humanize()> and use it instead of
C<to_human_string()>, to save on typing.

=head2 C<h>

    printf "Report(s) for %s.\n", h qw/March May June August/;
    
You can optionally import C<h()> and use it instead of
C<to_human_string()>, to save on typing.

=head1 AUTHOR

Zoffix Znet, C<< <zoffix at cpan.org> >>

=head1 GIT

This module is on GitHub:
L<https://github.com/zoffixznet/List-ToHumanString.git>

=head1 BUGS

Please report any bugs or feature requests to C<bug-list-tohumanstring at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=List-ToHumanString>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc List::ToHumanString

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=List-ToHumanString>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/List-ToHumanString>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/List-ToHumanString>

=item * Search CPAN

L<http://search.cpan.org/dist/List-ToHumanString/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Zoffix Znet.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
