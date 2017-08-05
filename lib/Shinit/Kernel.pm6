use v6.c;
use NativeCall;
unit module Shinit::Kernel;

sub reboot(int32 --> int32) is export is native("libc") { ... }
