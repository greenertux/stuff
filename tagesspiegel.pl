# Last change: 08/30/2015 by greenertux (Tristan Hoffmann)

# This is a script to fetch the digital version of the German newspaper Tagesspiegel automatically
# To be used with my script tagesspiegel.sh to send the kindle version directly to your device over WiFi every morning.

# You will need a regular subscription, this script only automates the download process.

# Changes required: 
# 1) Update customer number and zip code

# Installation
# Prerequsites: you need perl and perl-CPAN (CentOS: yum install perl-CPAN)
#		you'll also need the perl modules WWW:Mechanize and File::Slurp 
#			-> install though package manager of your distribution or try the method below 
# Run % perl -MCPAN -e shell                    [as root]
#     > install WWW::Mechanize (had to run yum install perl-libwww-perl perl-XML-TreeBuilder before)
#     > install File::Slurp

use warnings;
use strict;
use WWW::Mechanize;
use File::Slurp;

my $mech = WWW::Mechanize->new;
$mech->get('http://abo.tagesspiegel.de/aboangebote/e-paper') || die;
$mech->submit_form( fields => { customer_number => '##########', zip_code => '#####', submit => ''} ) || die;
use POSIX; 
my $date = strftime("%d.%m.%Y", localtime(time));
print "Downloading Kindle for day " . $date . "\n";
my $url = 'http://e-paper.tagesspiegel.de/epaper/econtent.php?rel=a4' . $date;
my $file = 'Tagesspiegel-'.$date.'.mobi';
$mech->get($url);
File::Slurp::write_file($file, $mech->content);
