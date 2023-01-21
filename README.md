trackjunkie
===========

Automating my attempts at clustering track days for some epic road trips.

`junkie.pl` dowloads all of the events from HPDE Junkie. This is probably
updated at several points during the year, and will need to be run a few times.

	perl junkie.pl > 2023-automated

There may be other events not listed, for example open test days or private
events. Also, HPDE Junkie shows Canadian tracks but doesn't list them. These
types of extras will have to be added manually to `2023-manual`.

Then some later script reads these files and clusters track dates by region.

## Log ##

+ 2023-01-21: first check-in, 1496 track events listed
