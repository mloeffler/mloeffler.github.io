{smcl}
{* *! version 0.1, 25nov2014}{...}
{viewerjumpto "Syntax" "wordwrap##syntax"}{...}
{viewerjumpto "Description" "wordwrap##description"}{...}
{viewerjumpto "Options" "wordwrap##options"}{...}
{viewerjumpto "Example" "wordwrap##example"}{...}
{viewerjumpto "Author" "wordwrap##author"}{...}
{viewerjumpto "License" "wordwrap##license"}{...}
{title:Title}

{phang}
{bf:wordwrap} {hline 2} Wraps a string to a specific number of characters


{marker syntax}{title:Syntax}

{p 8 17 2}
{cmd:wordwrap}
{it:{help strings:string}}
[{cmd:,} {cmdab:l:ength(}{it:integer}{cmd:)}]


{marker description}{...}
{title:Description}

{pstd}
{opt wordwrap} breaks a very long string into pieces and wraps the text to a
specific line length that can be specified. No hyphenation supported.


{marker options}{...}
{title:Options}

{phang}
{opt l:ength} specifies the maximum number of characters before the line
breaks. Default is 80 characters if you don't specify a length.


{marker example}{...}
{title:Example}

{pstd}
Using {opt wordwrap} is really simple. Let's look at an example:

{phang2}. {stata local text = "This is a pretty short note with text."}{p_end}
{phang2}. {stata sysuse auto}{p_end}
{phang2}. {stata scatter weight length, note("`text'")}{p_end}

{pstd}
This note is short. But still, we may break it into several lines:

{phang2}. {stata wordwrap "`text'", l(10)}{p_end}
{phang2}. {stata scatter weight length, note("`r(text)'")}{p_end}

{pstd}
This is even shorter. Of course you wouldn't break a note like this into
pieces. But imagine how useful this could be if you had to document all the
details of your graph in one single very long note.


{marker author}{...}
{title:Author}

{pstd}
{cmd:wordwrap} was written by Max Löffler ({browse "mailto:loeffler@zew.de":loeffler@zew.de}),
Centre for European Economic Research (ZEW), Mannheim, Germany. Comments and
suggestions are welcome.

{pstd}
{browse "http://www.stata.com/statalist/archive/2007-03/msg00778.html":Scott Merryman}
and {browse "http://www.stata.com/statalist/archive/2008-01/msg00579.html":Raymond P. Guiteras}
posted very similar code on the Stata list a few years ago. All credit goes to
them for pointing out this simple way of breaking long lines. The example given
above is taken from their posts.


{marker license}{...}
{title:License}

{pstd}
Copyright (C) 2014, {browse "mailto:loeffler@zew.de":Max Löffler}

{pstd}
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

{pstd}
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

{pstd}
You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

