import 'dart:ui';
import 'package:SquareGame/langaw-game.dart';

// Notes: The Fly component should be able to remember where it(X and Y)is and how big it it (height and width)
// This would be 4 variables, it is more efficient a data type that contains x/y and height/width values
// Rect: constructed (via the fromLTWH factory), you’re supposed to define it’s Left (or x), Top (or y), Width and Height.
// Rect: instances are immutable




class Fly {
  // import dart’s ui package so that we can access the Canvas class
  final LangawGame game;
  Rect flyRect;

  // to avoid re-initializing the Paint object inside the render method, let’s store it in an instance variable.
  Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;


  Fly(this.game, double x, double y) {
    // this.game assigns the value of whatever is passed into the game property
    // x and y will be the initial position of the newly constructed instance
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    // we assign a new rectangle to 'flyRect' using the x and y for Left and Top and then 'game.tileSize' for Width and Height
    flyPaint = Paint();
    flyPaint.color = Color(0xffffda79);
  }

  void render(Canvas c) {
    c.drawRect(flyRect, flyPaint);
  }

  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }

  }
  void onTapDown() {
    isDead = true;
    flyPaint.color = Color(0xffff5252);
    game.spawnFly();
  }
}