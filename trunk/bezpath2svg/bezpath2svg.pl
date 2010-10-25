#!/usr/bin/perl

my @lines; # obsah poskytnuteho souboru
my $svg_header; # hlavicka SVG
my $svg_footer; # ukonceni SVG
my $svg_body; # telo SVG
my $line; # aktualni radek
my $name_param; # jmeno prvniho parametru
my @svg_path_begins; # zacatky cest jednostlivych baev
my @colors; # barvy jednotlivych cest

$name_param = $ARGV[0];

my @colors = ('00ff00','0000ff','ffff00');

$i=0;
for ($i=0;$i<@colors;$i++)
{
	$svg_path_begins[$i]='<path
     style="fill:none;stroke:#'.$colors[$i].';stroke-width:4;stroke-linecap:square;stroke-linejoin:miter;stroke-opacity:1"
     d="';
}


@lines = <ARGV>;

$svg_header = '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN"
"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg width="800" height="600"
     viewBox="0 0 800 600"
     xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink">';
$svg_footer = '</svg>';

$svg_body='';
$svg_path_end = '" />';

$svg_body.=$svg_path_begin;

$i = 0;

foreach $line (@lines)
{
   #print $line;
   if ($line!~/[0-9]+\.[0-9]+ [-]?[0-9]+\.[0-9]+ [a-z]+/)
   {
	if ($line=~/Path <0x[0-9a-f]*>/)
	{
		$svg_body.=$svg_path_end;	
		$svg_body.=$svg_path_begins[$i];
		$i++;
	}
   	next;
   } else
   {
  	$line =~ s/^ +([-]?[0-9]+\.[0-9]+) ([-]?[0-9]+\.[0-9]+) ([a-z])[a-z]+$/\u\3 \1 \2/;
	$svg_body .= $line;
   }

}


$svg_body.=$svg_path_end;


$name_param =~ s/\.[^\/]*$//;

open (SVGFILE,">".$name_param.".svg");

print SVGFILE $svg_header;
print SVGFILE $svg_body;
print SVGFILE $svg_footer;

close(SVGFILE);

print "Konverze probehla uspesne, vysledek byl ulozen do souboru ".$name_param.".svg\n";



