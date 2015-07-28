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
my $url = 'http://epaper.tagesspiegel.de/epaper/econtent.php?rel=a4' . $date;
my $file = 'Tagesspiegel-'.$date.'.mobi';
$mech->get($url);
File::Slurp::write_file($file, $mech->content);
