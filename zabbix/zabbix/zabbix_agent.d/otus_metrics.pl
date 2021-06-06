#!/usr/bin/perl -w
use strict;

my $json = "{\"data\":[";
for(my $i = 0; $i < 3; ++$i) {
  my $value = int(rand(101));
  my $metric = "otus_important_metrics$value";
  $json .= "{\"{#METRIC}\":\"$metric\"}";
  $json .= "," unless $i == 2;
}

$json .= "]}";
print $json;
