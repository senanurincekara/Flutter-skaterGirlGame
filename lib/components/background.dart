import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:rungame/game/assets.dart';
import 'package:rungame/game/skateboardera_girl.dart';

class Background extends SpriteComponent with HasGameRef<skateboarderGirl> {
  Background();
  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
