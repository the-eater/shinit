use v6.c;
use Shinit::Stage;
use Shinit::Util;

class Shinit {
  has Map $.stages;
  has Int $.current-stage is rw = 0;

  submethod BUILD() {
    $!stages = {};
    $!stages{$_} = Shinit::Stage.new(stage => $_) for 1..3;
  }

  method run {
    repeat {
      my $stage-promise = self!push-stage;
      await $stage-promise;
      if $stage-promise.status !~~ Kept || !$stage-promise.result {
        say "Stage {$.current-stage} failed :(";
        give-control("/usr/bin/bash");
      }
    } while $.current-stage < $.stages.elems
  }

  method !push-stage {
    $.current-stage++;
    my $stage = $.stages{$.current-stage};

    say "Running stage {$.current-stage}";
    start {
      $stage.run;
    }
  }
}
