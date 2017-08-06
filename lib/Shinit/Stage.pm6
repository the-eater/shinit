use v6.c;

class Shinit::Stage {
  has Int $.stage;

  method run() {
    try  {
      CATCH {
        default {
          say "Stage {$.stage} failed with:"
          say .Str;
          return False;
        }
      }

      await run '/etc/shinit/' ~ $.stage;
    }

    True;
  }
}
