use v6.c;

class Shinit::Stage {
  has Int $.stage;

  method run() {
    if ! try await run '/etc/shinit/' ~ $.stage {
      return False;
    }

    True;
  }
}
