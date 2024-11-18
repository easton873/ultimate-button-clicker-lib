import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/clicker_escape.dart';
import 'package:button_clicker/game/const.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('format numbers', () async {
    expect(Constants.displayDouble(1000), "1,000.0");
    expect(Constants.displayDouble(123456789), "123,456,789.0");
    expect(Constants.displayDouble(1), "1.0");
    expect(Constants.displayDouble(1238000000000000000000.123), "1.238e+21");
  });

  test('format with commas', () {
    expect(Constants.formatWithCommas("1000"), "1,000");
    expect(Constants.formatWithCommas("100"), "100");
    expect(Constants.formatWithCommas("10"), "10");
    expect(Constants.formatWithCommas("10.0"), "10.0");
    expect(Constants.formatWithCommas("100.0"), "100.0");
    expect(Constants.formatWithCommas("1000.0"), "1,000.0");
  });

  test('test dropping decimal', () async {
    expect(Constants.dropDecimalFromDouble(1.23), "1");
    expect(Constants.dropDecimalFromDouble(8000000000000000000.123), "8000000000000000000");
    expect(Constants.dropDecimalFromDouble(1238000000000000000000.123), "1.238e+21");
  });

  test('cost of clickers', () async {
    Clicker clicker = Clicker("test", 0, 100, 1, 1.1);
    expect(clicker.getCost(1).round(), 100);
    expect(clicker.getCost(2).round(), 210);
    expect(clicker.getCost(3).round(), 331);
    clicker.quantity = 1;
    expect(clicker.getCost(1).round(), 110);
    expect(clicker.getCost(2).round(), 231);

    // another cost increase rate
    clicker = Clicker("test", 0, 1, 1, 1.01);
    expect(clicker.getCost(1).round(), 1.00);
    expect(clicker.getCost(2), 2.009999999999999);
  });

  test('buyable amount of clickers', () async {
    Clicker clicker = Clicker("test", 0, 100, 1, 1.1);
    expect(clicker.getBuyableAmount(105), 1);
    expect(clicker.getBuyableAmount(215), 2);
    clicker.quantity = 1;
    expect(clicker.getBuyableAmount(112), 1);
    expect(clicker.getBuyableAmount(105), 0);
    expect(clicker.getBuyableAmount(1), 0);
  });

  test('buyable glitch', () async {
    Clicker clicker = Clicker("test", 0, 1000.0, 10.0, 1.1);
    int amount = clicker.getBuyableAmount(160);
    expect(amount, 0);
  });

  test('increase by 1.0', () async {
    Clicker clicker = ClickerEscape("test", 0, 100.0, 10.0, 1.0);
    int amount = clicker.getBuyableAmount(101);
    expect(amount, 1);
    double cost = clicker.getCost(1);
    expect(cost, 100.0);
  });

  test('decrease by 50%', () async {
    Clicker clicker = Clicker("test", 0, 100.0, 10.0, 0.5);
    int amount = clicker.getBuyableAmount(151);
    expect(amount, 2);
  });

  test('negative clicks', () async {
    Clicker clicker = ClickerEscape("test", 0, 100.0, 10.0, 1.0);
    int amount = clicker.getBuyableAmount(-101);
    expect(amount, -1);
  });
}