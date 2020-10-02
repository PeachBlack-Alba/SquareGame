
import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:SquareGame/components/fly.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game/base_game.dart';






class LangawGame extends Game {
  // Size and Canvas are part of the UI packages
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  // we add random from the maths package to set up a random initial position for the flies(squares)
  // we won’t have to create a new instance of Random every time we need something random.
  Random rnd;



  LangawGame() {
    initialize();
  }

  void initialize() async {
    // flies will initialize first
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    spawnFly();

  }

  void spawnFly() {
    //*
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    // rnd ->random position of X and Y
    flies.add(Fly(this, x, y));
  }

  void render(Canvas canvas) {
    // background
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff33d9b2);
    canvas.drawRect(bgRect, bgPaint);
    // flies
    flies.forEach((Fly fly) => fly.render(canvas));

  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    //  removeWhere is a Dart method
    flies.removeWhere((Fly fly) => fly.isOffScreen);

  }

  void resize(Size size) {
    // What this does is  store the new size passed by Flutter into the
    // screenSize instance variable so we can access it later in different parts of our game loop.
    screenSize = size;
    // This variable will hold the value of the width of the screen divided by nine
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }
}









//* What we’ll do is call this method and multiply it by the width of the screen minus the width of the fly,
// since the “position” of the fly is in its upper-left corner, and assign it to the initial X.
// We’ll do the same with the initial Y but using the screen’s height minus the height of the fly.
// square is the same size of the tile