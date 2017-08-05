use v6.c;
use NativeCall;
unit module Shinit::Kernel;

sub reboot(int --> int) is export is native("libc");
