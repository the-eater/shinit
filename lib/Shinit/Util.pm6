use v6.c;
unit module Shinit::Util;

sub give-control(*@command) is export {
  run |@command;
}
