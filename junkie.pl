system("curl https://hpdejunkie.com > temp1") == 0 or die "curl 1 failed";
my $contents;
open(my $fh, "temp1") or die;
while (<$fh>) {$contents .= $_}
my @url;
while ($contents =~ /locations\/([\S]+)">([\w ]+)</g) {
	push @url, "https://hpdejunkie.com/locations/$1";
}

foreach my $url (@url) {
	proc($url);
}

sub proc {
	my ($url) = @_;
	system("curl $url > temp2") == 0 or die "curl 2 failed";

	open(my $fh, "temp2");
	$contents = "";
	while (<$fh>) {$contents .= $_}

	my ($track) = $contents =~ /<title>.+Events\s+(.+) - HPDE Junkie/;

	while ($contents =~ /<li>(.+?)<\/li>/g) {
		my $event = $1;
		my ($url) = $event =~ /href="(\S+)"/;
		my ($host) = $event =~ />([\w ]+)<\/a>/;
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
