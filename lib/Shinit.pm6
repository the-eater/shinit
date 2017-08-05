use v6.c;
use Shinit::Stage;
use Shinit::Kernel;

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
        run "/usr/bin/bash";
      }
    } while $.current-stage < $.stages.elems;

    say "Ran all stages! time to reboot";
    reboot(0x1234567);
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
