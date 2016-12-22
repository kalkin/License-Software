NAME
====

License::Software - Automation interface for applying licenses to software projects.

SYNOPSIS
========

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

DESCRIPTION
===========

Applying a license to your software is not an easy task. Different licenses dictate different usage rules. A prime example of a “complicated” license is the GNU General Public License ([https://www.gnu.org/licenses/gpl.txt](https://www.gnu.org/licenses/gpl.txt)) and the GNU Lesser General Public License ([https://www.gnu.org/licenses/lgpl.txt](https://www.gnu.org/licenses/lgpl.txt)).

[Legal::License::Software](Legal::License::Software) provides a common “interface” for defining software license templates. Software licenses and their usage practices differ greatly, but they have a number of common properties:

  * One or multiple copyright holders (authors).

  * Copyright notice per holder

  * Year or year range (i.e: 2000-2010) per holder

  * Copying permission, stating under which terms the software is distributed

  * Header to be added at the beginning of each licensed file

  * Minor things, like url, short-name & name aliases

COPYRIGHT
=========

Copyright ⓒ 2016 Bahtiar `kalkin-` Gadimov <bahtiar@gadimov.de>

LICENSE
=======

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.se v6;
