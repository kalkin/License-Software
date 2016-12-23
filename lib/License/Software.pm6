=NAME License::Software - Automation interface for applying licenses to software projects.

unit module License::Software;
use License::Software::Abstract;
use License::Software::GPLv3;
use License::Software::Apache2;
use License::Software::AGPLv3;
use License::Software::LGPLv3;
use License::Software::Artistic2;


=begin SYNOPSIS
=begin code
    use License::Software;
    my $author = 'Max Musterman';
    my $license = License::Software.get('gpl').new($author);

=end code
=end SYNOPSIS

=begin DESCRIPTION

=end DESCRIPTION

our sub get-all returns List { 
    return eager License::Software::.values.list ==> grep( { 
        $_ ~~ License::Software::Abstract && 
        $_.^name !~~ 'License::Software::Abstract' 
    })
    # ==> map *.^name.split('::')[*-1]
}

our sub get(Str:D $alias) returns License::Software::Abstract
{
    for get-all() -> $license { return $license if $alias.uc ∈ $license.aliases».uc }
    warn "Can not find license alias '$alias'";
}

our sub from-url(Str:D $url ) returns License::Software::Abstract
{
    for get-all() -> $license { return $license if $url ~~ $license.url }
    warn "Can not find license with url '$url'";
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
