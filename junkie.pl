use strict;
use warnings FATAL => 'all';


## Track Abbreviations ##

my %TRACK = (
	'Apex Motor Club' => 'Apex',
	'Arroyo Seco Raceway' => 'ASR',
	'Atlanta Motor Speedway' => 'AMS',
	'Arizona Motorsports Park' => 'Ariz',
	'Atlanta Motorsports Park' => 'AMP',
	'Autobahn Country Club' => 'ACC',
	'Auto Club Speedway' => 'ACS',
	'Barber Motorsports Park' => 'BMP',
	'Blackhawk Farms Raceway' => 'BFR',
	'Brainerd International Raceway' => 'BIR',
	'Buttonwillow Raceway' => 'BRP',
	'Buttonwillow Raceway - New Track' => 'BRP2',
	'Calabogie Motorsports Park' => 'Cala',
	'Canaan Motor Club' => 'CMC',
	'Canadian Tire Motorsports Park/Mosport' => 'CTMP',
	'Carolina Motorsports Park' => 'CMP',
	'Charlotte Motor Speedway' => 'CMS',
	'Chuckwalla Valley Raceway' => 'CVR',
	'Circuit of the Americas' => 'CotA',
	'Club Motorsports' => 'Club',
	'Colorado State Patrol Track' => 'CSPT',
	'Dakota County Technical College' => 'DCTC',
	'Daytona International Speedway' => 'DIS',
	'Dominion Raceway' => 'Dom',
	'Eagles Canyon Raceway' => 'ECR',
	'Englishtown Raceway Park' => 'ERP',
	'Flatrock Motorsports park' => 'FMP',
	'Gateway Motorsports Park' => 'Gate',
	'Gingerman Raceway' => 'Ging',
	'GrandSport Speedway' => 'GS',
	'Grattan Raceway' => 'Grat',
	'Hallett Motor Racing Circuit' => 'HMRC',
	'Harris Hill Raceway' => 'HHR',
	'Heartland Park Topeka' => 'HPT',
	'High Plains Raceway' => 'HPR',
	'Homestead Miami Speedway' => 'HMS',
	'INDE Motorsports Ranch' => 'IMR',
	'Indianapolis Motor Speedway' => 'Indy',
	'Kansas Speedway', => 'KS',
	'La Junta Raceway' => 'LJR',
	'Las Vegas Motor Speedway' => 'LVMS',
	'Lime Rock Park' => 'LRP',
	'M1 Concourse' => 'M1C',
	'Memphis International Raceway' => 'MIR',
	'Mid-Ohio Sports Car Course' => 'MidO',
	'Milwaukee Mile' => 'MM',
	'Mont Tremblant' => 'MT',
	'Monticello Motor Club' => 'MMC',
	'Motorsport Park Hastings' => 'MPH',
	'Motorsport Ranch Cresson' => 'MRC',
	'MSR Houston' => 'MSRH',
	'Musselman Honda Circuit' => 'MHC',
	'Nashville Super Speedway' => 'NSS',
	'NCCAR' => 'NCAR',
	'NCM - National Corvette Museum' => 'NCM',
	'Nelson Ledges Road Course' => 'NLRC',
	'New Hampshire Motor Speedway' => 'NHMS',
	'New Jersey Motorsports Park/Lightning' => 'NJ-L',
	'New Jersey Motorsports Park/Thunderbolt' => 'NJ-T',
	'New York Safety Track' => 'NYST',
	'Nola Motorsports Park' => 'Nola',
	'Oregon Raceway Park' => 'ORP',
	'Ozarks International Raceway' => 'OIR',
	'Pacific Raceway' => 'Pac',
	'Palm Beach International Raceway' => 'PBIR',
	'Palmer Motorsports Park' => 'PMP',
	'Pikes Peak International Raceway' => 'PPIR',
	'Pine View Run' => 'PVR',
	'Pittsburgh International Race Complex' => 'Pitt',
	'Pocono Raceway' => 'Poc',
	'Podium Club at Attesa' => 'PCaA',
	'Polecat Training Center' => 'PTC',
	'Portland International Raceway' => 'PIR',
	'Pueblo Motorsports Park' => 'Pueb',
	'Putnam Park' => 'PP',
	'Raceway Park of the Midlands' => 'RPM',
	'Radford Racing' => 'Rad',
	'Resolute Motorsports Club' => 'RMC',
	'Road America' => 'RAm',
	'Road Atlanta' => 'RAt',
	'Rockingham Speedway &quot;The Rock&quot;' => 'RS',
	'Roebling Road' => 'RR',
	'Sebring International Raceway' => 'SIR',
	'Sonoma Raceway' => 'SR',
	'Spokane &#039;Qlispe&#039; Raceway Park' => 'Spok',
	'Spring Mtn Motorsports Ranch' => 'SMMR',
	'Streets of Willow' => 'SoW',
	'Summit Point/Jefferson' => 'SP-J',
	'Summit Point - Main' => 'SP-M',
	'Summit Point/Shenandoah Course' => 'SP-S',
	'Talladega Grand Prix Raceway' => 'TGPR',
	'Texas Motor Speedway' => 'TMS',
	'Texas World Speedway' => 'TWS',
	'The Firm' => 'Firm',
	'The Ridge Motorsports Park' => 'RMP',
	'The Thermal Club' => 'TTC',
	'Thompson Speedway' => 'TS',
	'Thunderhill Raceway' => 'TRP',
	'Utah Motorsports Campus' => 'UMC',
	'VIR Virginia International Raceway' => 'VIR',
	'Waterford Hills' => 'WH',
	'Watkins Glen International - &quot;The Glen&quot;' => 'WGI',
	'WeatherTech Raceway / Laguna Seca' => 'LS',
	'Wild Horse Pass East' => 'WH-E',
	'Wild Horse Pass Main' => 'WH-M',
	'Wild Horse Pass West' => 'WH-W',
	'Willow Springs Road Course' => 'WSIR',
);

my %check;
foreach my $name (keys %TRACK) {
	$check{$TRACK{$name}}++;
}
foreach my $name (keys %check) {
	if ($check{$name} > 1) {
		die "abbreviation collision at $name";
	}
}

## HPDE Junkie Donwload ##

if (!-e "build/hpdejunkie") {
	system("curl https://hpdejunkie.com > build/hpdejunkie") == 0
		or die "curl hpdejunkie failed";
}
my $contents;
open(my $fh, "build/hpdejunkie") or die;
while (<$fh>) {$contents .= $_}
my @url;
while ($contents =~ /locations\/([\S]+?)">([\S ]+?)</g) {
	push @url, "https://hpdejunkie.com/locations/$1";
}

foreach my $url (@url) {
#	print $url, "\n";
	proc($url);
}

sub proc {
	my ($url) = @_;
	my $furl = $url;
	$furl =~ s/\//=/g;
	if (!-e "build/$furl") {
		system("curl $url > build/$furl") == 0 or die "curl 2 failed";
	}

	open(my $fh, "build/$furl");
	$contents = "";
	while (<$fh>) {$contents .= $_}

	my ($track) = $contents =~ /<title>.+Events\s+(.+) - HPDE Junkie/;
	if (not defined $TRACK{$track}) {die "$track not found"}
	$track = $TRACK{$track};

	while ($contents =~ /<li>(.+?)<\/li>/g) {
		my $event = $1;
		my ($url) = $event =~ /href="(\S+)"/;
		my ($host) = $event =~ />([\S ]+)<\/a>/;
		my @date;
		while ($event =~ /(\d\d)\/(\d\d)\/(\d{4})/g) {
			push @date, "$3$1$2";
		}
		if (@date > 2) {
			for (my $d = $date[0] +1; $d < $date[1]; $d++) {
				push @date, $d;
			}
		}
		foreach my $date (@date) {
			print join("\t", $date, $track, $url, $host), "\n";
		}
	}
}

__END__

Temp files are saved because I expect this script will break when they update
their formatting sometime in the future, and this will help debugging.
