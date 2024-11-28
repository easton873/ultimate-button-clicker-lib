import 'package:button_clicker/game/game_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test bonus increase rate', () async {
    GameData data = GameData.fromUserInput("saveKey", "summaryText", "thingProduced", "thingProducedPlural", "bonusName", "bonusPlural", 1.0, 10, 1.1, 100, []);
    expect(data.getBonus(10), 1.0);
    expect(data.getBonus(21), 2.0);
    expect(data.getBonus(33.1).toInt(), 3.0.toInt());
  });
}