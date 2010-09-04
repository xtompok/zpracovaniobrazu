#!/usr/bin/perl

my @lines; # obsah poskytnuteho souboru
my $svg_header; # hlavicka SVG
my $svg_footer; #ukonceni SVG
my $svg_body; #telo SVG
my $line; # aktualni radek
my $name_param; #jmeno prvniho parametru

$name_param = $ARGV[0];

@lines = <ARGV>;

$svg_header = '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN"
"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg width="800" height="600"
     viewBox="0 0 800 600"
     xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink">';
$svg_footer = '</svg>';

$svg_body='<path
     style="fill:none;stroke:#00ff00;stroke-width:4;stroke-linecap:square;stroke-linejoin:miter;stroke-opacity:1"
     d="';

foreach $line (@lines)
{
   #print $line;
   if ($line!~/[0-9]+\.[0-9]+ [0-9]+\.[0-9]+ [a-z]+/)
   {
   	next;
   } else
   {
  	$line =~ s/^ +([0-9]+\.[0-9]+) ([0-9]+\.[0-9]+) ([a-z])[a-z]+$/\u\3 \1 \2/;
	#print $line;
	$svg_body .= $line;
   }

}

$svg_body .= '" />';

$name_param =~ s/\..*$//;

open (SVGFILE,">".$name_param.".svg");

print SVGFILE $svg_header;
print SVGFILE $svg_body;
print SVGFILE $svg_footer;

close(SVGFILE);

print "Konverze probehla uspesne, vysledek byl ulozen do souboru ".$name_param.".svg\n";



