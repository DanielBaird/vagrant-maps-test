performance log
===============

Setup: Vagrant VM / 1Gb RAM / 10,000 layers
-------------------------------------------

100 fetches of tile from item at index 1: 26 seconds
100 fetches of tile from item at index 10: 20 seconds
100 fetches of tile from item at index 100: 15 seconds
100 fetches of tile from item at index 1000: 15 seconds
100 fetches of tile from item at index 10000: 13 seconds

100 fetches of tile from item at index 1: 12 seconds
100 fetches of tile from item at index 10: 13 seconds
100 fetches of tile from item at index 100: 12 seconds
100 fetches of tile from item at index 1000: 13 seconds
100 fetches of tile from item at index 10000: 12 seconds

100 fetches of tile from item at index 1: 11 seconds
100 fetches of tile from item at index 10: 12 seconds
100 fetches of tile from item at index 100: 12 seconds
100 fetches of tile from item at index 1000: 12 seconds
100 fetches of tile from item at index 10000: 11 seconds

100 fetches of tile from item at index 1: 12 seconds
100 fetches of tile from item at index 10: 13 seconds
100 fetches of tile from item at index 100: 13 seconds
100 fetches of tile from item at index 1000: 14 seconds
100 fetches of tile from item at index 10000: 13 seconds

100 fetches of tile from item at index 1: 13 seconds
100 fetches of tile from item at index 10: 11 seconds
100 fetches of tile from item at index 100: 11 seconds
100 fetches of tile from item at index 1000: 12 seconds
100 fetches of tile from item at index 10000: 13 seconds


Setup: Vagrant VM / 1Gb RAM / 10,000 layers / JDBCConfig
--------------------------------------------------------

System had 10k layers, then dbconfig plugin was installed.

100 fetches of tile from item at index 1: 44 seconds
100 fetches of tile from item at index 10: 26 seconds
100 fetches of tile from item at index 100: 27 seconds
100 fetches of tile from item at index 1000: 21 seconds
100 fetches of tile from item at index 10000: 20 seconds

100 fetches of tile from item at index 1: 18 seconds
100 fetches of tile from item at index 10: 17 seconds
100 fetches of tile from item at index 100: 18 seconds
100 fetches of tile from item at index 1000: 18 seconds
100 fetches of tile from item at index 10000: 18 seconds

(restarted VM here)

100 fetches of tile from item at index 1: 107 seconds
100 fetches of tile from item at index 10: 26 seconds
100 fetches of tile from item at index 100: 20 seconds
100 fetches of tile from item at index 1000: 19 seconds
100 fetches of tile from item at index 10000: 18 seconds

100 fetches of tile from item at index 1: 15 seconds
100 fetches of tile from item at index 10: 15 seconds
100 fetches of tile from item at index 100: 15 seconds
100 fetches of tile from item at index 1000: 15 seconds
100 fetches of tile from item at index 10000: 15 seconds


Setup: Vagrant VM / 1Gb RAM / 34,000 layers / JDBCConfig
--------------------------------------------------------

System had a few layers (the default install has a dozen or 
so sample layers), then dbconfig plugin was installed.

A "add testing layers" script inserted fake layers one by one
using curl and the geoserver REST interface. The goal was
100,000 layers but setup was stopped at 34225 layers due
to slow insertions, which dwindled from 288 per minute in 
the first few thousand down to about 95 per minute.

100 fetches of tile from item at index 1: 104 seconds
100 fetches of tile from item at index 10: 30 seconds
100 fetches of tile from item at index 100: 27 seconds
100 fetches of tile from item at index 1000: 24 seconds
100 fetches of tile from item at index 10000: 22 seconds

100 fetches of tile from item at index 1: 98 seconds
100 fetches of tile from item at index 10: 24 seconds
100 fetches of tile from item at index 100: 20 seconds
100 fetches of tile from item at index 1000: 23 seconds
100 fetches of tile from item at index 10000: 20 seconds

100 fetches of tile from item at index 1: 25 seconds
100 fetches of tile from item at index 10: 22 seconds
100 fetches of tile from item at index 100: 28 seconds
100 fetches of tile from item at index 1000: 22 seconds
100 fetches of tile from item at index 10000: 21 seconds





