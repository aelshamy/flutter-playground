abstract class Fighter {
  KickBehavior kickBehavior;
  JumpBehavior jumpBehavior;

  Fighter(this.kickBehavior, this.jumpBehavior);

  void kick() {
    kickBehavior.kick();
  }

  void jump() {
    jumpBehavior.jump();
  }

  void display();

  void roll() {
    print('Roll');
  }

  void punch() {
    print('Punch');
  }
}

abstract class KickBehavior {
  void kick();
}

class LightningKick implements KickBehavior {
  @override
  void kick() {
    print('This is a Lightning Kick');
  }
}

class TornadoKick implements KickBehavior {
  @override
  void kick() {
    print('This is a Tornado Kick');
  }
}

abstract class JumpBehavior {
  void jump();
}

class LongJump implements JumpBehavior {
  @override
  void jump() {
    print('This is a Long Jump');
  }
}

class ShortJump implements JumpBehavior {
  @override
  void jump() {
    print('This is a Short Jump');
  }
}

class Paul extends Fighter {
  Paul(KickBehavior kickBehavior, JumpBehavior jumpBehavior) : super(kickBehavior, jumpBehavior);

  @override
  void display() {
    print("Hi, I am Paul");
  }
}

void main() {
  final JumpBehavior longJump = LongJump();
  final JumpBehavior shortJump = ShortJump();

  final KickBehavior lightningKick = LightningKick();
  final KickBehavior tornadoKick = TornadoKick();

  final Fighter paul = Paul(tornadoKick, shortJump);

  paul.display();
  paul.punch();
  paul.kick();
  paul.jump();
  paul.jumpBehavior = longJump;
  paul.kickBehavior = lightningKick;

  paul.kick();
  paul.jump();
}
