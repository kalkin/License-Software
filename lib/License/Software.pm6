=NAME License::Software - Automation interface for applying licenses to software projects.

unit module License::Software;

=begin SYNOPSIS
=begin code
    use License::Software;

    class MyLicense does License::Software::Abstract
    {
        has $.name = 'My License';
        has $.short-name = 'MLC';
        has @.aliases = $!short-name, 'MLCv2';
        has %.files = 'LICENSE' => $!full-text;
        has %.full-text = 'My license text';

        method header() { return "My Header"};
        method note() {
        q:to<END>;
        This software is licensed under MyLicense version 3.0
        END
        };

    }

    my $license = MyLicense.new("Hans Wurst <hans@example.com>")

    say $license.full-text();
    say $license.note();
=end code
=end SYNOPSIS

=begin DESCRIPTION

Applying a license to your software is not an easy task. Different licenses
dictate different usage rules. A prime example of a “complicated” license is the
GNU General Public License (L<https://www.gnu.org/licenses/gpl.txt>) and the GNU
Lesser General Public License (L<https://www.gnu.org/licenses/lgpl.txt>).

L<Legal::License::Software> provides a common “interface” for defining software
license templates. Software licenses and their usage practices differ greatly,
but they have a number of common properties:

=item One or multiple copyright holders (authors).
=item Copyright notice per holder
=item Year or year range (i.e: 2000-2010) per holder
=item Copying permission, stating under which terms the software is distributed
=item Header to be added at the beginning of each licensed file
=item Minor things, like url, short-name & name aliases

=end DESCRIPTION

subset MyDateish of Dateish where
{
    .year >= 0 or warn "Licensing year Dateish value must be *.year >= 0"
};

subset YearRange of Range where {
    .is-int and all(.int-bounds) >= 0 or
        warn "Licensing YearRange both endpoints must be Int values and have bounds 0.." ;
};

subset Year where UInt | MyDateish | YearRange;
class Holder {
    has Str $.name;
    has Year $.year = DateTime.new(time).year;

    method new(Str:D $name) {
        self.bless(:$name);
    }
}

role Abstract {

    has Str $.works-name = 'This program';
    has Str $.copyright = "Copyright ⓒ";
    has Holder @.holders;

    multi method copyright-note returns Str
    {
        die "No @.holders set" if !@.holders;
        return $.copyright «~» @.holders».name ==> join "\n:" ;
    }

    multi method copyright-note(Holder $holder) returns Str {
        my Str $copyright = $.copyright;
        my $year;
        given $holder.year {
            when Dateish { $year = self.dateish-to-str($_) }
            when Range { $year = self.range-to-str($_) }
            default { $year = $_ }
        }

        $copyright ~= ' ' ~ $year ~ " " ~ $holder.name;
        return $copyright;
    }

    multi method copyright-note(Str $holder) returns Str {
        return self.copyright-note(Holder.new($holder))
    }

    method range-to-str(Range $range) returns Str:D { $range.gist.trans('.' => '-', :squash) }

    method dateish-to-str(Dateish $date) returns Str:D { $date.year.Str }

    method aliases returns Array[Str]  { Array[Str].new($.short-name) }
    method files returns Hash:D { … }
    method header returns Str:D  { … }
    method full-text returns Str:D  { … }
    method name returns Str { … }
    method note returns Str:D  { … }
    method short-name returns Str  { … }
    method url returns Str:D  { … }

}




=COPYRIGHT Copyright ⓒ 2016 Bahtiar `kalkin-` Gadimov <bahtiar@gadimov.de>

=begin LICENSE
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.se v6;
=end LICENSE
