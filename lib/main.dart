import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TextPaint textRenderer() => TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
                color: Colors.redAccent, offset: Offset(3, 3), blurRadius: 4),
          ],
        ),
      );

  List<String> alphabhets = ['G', 'E', 'E', 'K', 'Y', 'A', 'N', 'T', 'S'];
  MoveByEffect moveByEffect(Vector2 vector2, double startDelay) {
    return MoveByEffect(
      vector2,
      EffectController(
        duration: 2.5,
        curve: Curves.fastLinearToSlowEaseIn,
        startDelay: startDelay,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: FlameGame(
          children: [
            MyComponent()
              ..setOpacity(0.5)
              ..position = Vector2(MediaQuery.of(context).size.width / 2 - 80,
                  (MediaQuery.of(context).size.height / 2) - 100)
              ..add(
                ScaleEffect.to(
                  Vector2(2, 2),
                  EffectController(
                    duration: 2.5,
                    curve: Curves.fastLinearToSlowEaseIn,
                    startDelay: 22,
                  ),
                ),
              )
              ..add(
                OpacityEffect.fadeIn(
                  EffectController(
                    duration: 2.5,
                    curve: Curves.fastLinearToSlowEaseIn,
                    startDelay: 22,
                  ),
                ),
              )
              ..add(moveByEffect(Vector2(-75, -60), 22)),
            for (var i = 0; i < alphabhets.length; i++)
              TextComponent(
                text: alphabhets[i],
                position: Vector2(i * 30, -20),
                textRenderer: textRenderer(),
                anchor: Anchor.center,
              )
                ..add(moveByEffect(
                    Vector2(i + 80.0, (MediaQuery.of(context).size.height / 2)),
                    i * 1.2))
                ..add(moveByEffect(Vector2(-(i + 20.0), 0), (i + 1) * 1.2))
                ..add(
                  RotateEffect.by(
                    0.5,
                    EffectController(
                      duration: 0.5,
                      curve: Curves.easeOutExpo,
                      startDelay: (i + alphabhets.length) * 1.0,
                      alternate: true,
                      infinite: true,
                    ),
                  ),
                )
                ..add(moveByEffect(
                    Vector2(0, -50), (i + alphabhets.length) * 1.2))
                ..add(moveByEffect(
                    Vector2(MediaQuery.of(context).size.width, 0),
                    (i + alphabhets.length + 1) * 1.2)),
          ],
        ),
      ),
    );
  }
}

class MyComponent extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(150, 150);
    sprite = await Sprite.load('geeky_logo.png');
  }
}
