use v6.c;

class Shinit::Service {
  has Str $.service-path;
  has Proc::Async $!process;
  has Promise $!process-promise;
  has Bool $!stop = False;

  sub start {
    self!run(:!once)
  }

  sub start-once {
    self!run(:once);
  }

  sub !run(Bool :$once) {
    return if $!process.started && $!process-promise.status !~~ Planned;
    $!process = Proc::Async.new($.service-path);
    $!process-promise = $!process.start;

    if ! $once {
      self!monitor;
    }
  }

  sub !monitor {
    $!process-promise.then({
      if ! $!stop {
        self!run(:!once);
      }
    });
  }
}
