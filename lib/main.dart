import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SquareGame/langaw-game.dart';



void main() async {
  await setupFlame();
  // create an instance of game class and call the runApp function
  LangawGame game = LangawGame();
  runApp(game.widget);
}

Future setupFlame() async {
  LangawGame game = LangawGame();
  WidgetsFlutterBinding.ensureInitialized();
  var flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}

