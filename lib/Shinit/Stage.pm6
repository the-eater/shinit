use v6.c;

class Shinit::Stage {
  has Int $.stage;

  method run() {
    run '/etc/runit/' ~ $.stage;
  }
}
