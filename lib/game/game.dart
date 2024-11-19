import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/clicker_presenter.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game_data.dart';
import 'package:button_clicker/game/loadout_manager.dart';
import 'package:button_clicker/game/upgrades/upgrades.dart';
import 'package:button_clicker/save/from_json.dart';
import 'package:button_clicker/save/save_data.dart';
import 'package:button_clicker/save/to_json.dart';

class Game implements JsonUnmarshaller<Game>, JsonMarshaller {
  double _totalClicks;
  int _bonus;
  int _newBonus = 0;
  List<Clicker> clickers = [];
  GameData data;
  bool gameIsWon = false;

  DateTime lastSave;

  @override
  Game decodeJson(Map<String, dynamic> json) {
    return Game.fromJson(json);
  }

  @override
  Map<String, dynamic> encodeJson() {
    return toJson();
  }

  Game(Game game) : 
  _totalClicks = game._totalClicks,
  clickers = game.clickers,
  _bonus = game._bonus,
  _newBonus = game._newBonus,
  data = game.data,
  lastSave = game.lastSave,
  gameIsWon = false {
    updateWithTime(timeSinceLastSave());
  }

  Game.fromGameData(this.data) :
    _totalClicks = Upgrades().startingClick.getStartingClicks(),
    _bonus = 0,
    _newBonus = 0,
    clickers = data.clickers,
    lastSave = DateTime.now();

  Game.fromJson(Map<String, dynamic> json)
      : _totalClicks = json[Constants.gametotalClicks],
        _bonus = json[Constants.gameFood],
        _newBonus = json[Constants.gameNewFood],
        lastSave = DateTime.parse(json[Constants.gameLastSave]),
        data = LoadoutManager.loadouts[json[Constants.gameGameData]] ?? GameData.defaultData
  {
    List<dynamic> j = json[Constants.gameClickers] as List<dynamic>;
    for (dynamic jj in j) {
      clickers.add(ClickerPresenter.fromJson(jj));
    }
  }

  Map<String, dynamic> toJson() => {
    Constants.gameGameData: data.saveKey,
    Constants.gametotalClicks: _totalClicks,
    Constants.gameFood: _bonus,
    Constants.gameNewFood: _newBonus,
    Constants.gameClickers: [for (Clicker clicker in clickers) clicker.toJson()],
    Constants.gameLastSave: lastSave.toString(),
  };
  
  void save() {
    lastSave = DateTime.now();
    SaveData().saveGameData(this, data.saveKey);
  }

  void addClicks(double newClicks) {
    _totalClicks += newClicks;
    if (_totalClicks < 0) {
      _totalClicks = double.maxFinite;
    }
  }

  void update() {
    double total = 0;
    for (Clicker clicker in clickers) {
      total += clicker.addClicks(getBonus().toInt());
    }
    addClicks(total);
    calcNewFood();
  }

  void updateFromResume(Game data) {
    _totalClicks = data._totalClicks;
    updateWithTime(data.timeSinceLastSave());
  }


  Duration timeSinceLastSave(){
    return DateTime.now().difference(lastSave);
  }

  void updateWithTime(Duration duration) {
    addClicks(_getTotalClicksPerSecond() * duration.inSeconds);
  }

  bool detectWin() {
    return (_bonus + _newBonus) >= data.winningPoint || (_bonus + _newBonus) < 0;
  }

  double getClicks() {
    return _totalClicks;
  }

  String getFormattedNewBonus() {
    return Constants.displayInt(_newBonus);
  }

  void debugAddbonus() {
    _bonus += 10000000;
  }

  void spendClicks(double clicks) {
    _totalClicks -= clicks;
  }

  void click() {
    addClicks(Upgrades().power.getClickPower() * getBonus().toDouble());
    if (_getTotalClicksPerSecond() < (100 * getBonus())) {
      save();
    }
  }

  num _totalBonusRate() {
    return data.bonusRate * _bonus;
  }

  num getBonus() {
    return (1 + _totalBonusRate());
  }

  void setBonusTestONLY(int bonus){
    _bonus = bonus;
  }

  num getNumBonuses() {
    return _bonus;
  }

  int getNewBonus() {
    return _newBonus;
  }

  String _formatBonus(int b) {
    return "${Constants.displayDouble((b * data.bonusRate)*100)}%";
  }

  String getBonusPercentage() {
    return _formatBonus(_bonus);
  }

  String getNewBonusPercentage() {
    return _formatBonus(_newBonus);
  }

  void reset() {
    if (_bonus + _newBonus <= 0) {
      _bonus = Constants.maxInteger;
    } else {
      _bonus += _newBonus;
    }
    _newBonus = 0;
    _totalClicks = Upgrades().startingClick.getStartingClicks();
    resetClickers();
  }

  void resetClickers() {
    for (Clicker clicker in clickers) {
      clicker.reset();
    }
  }

  void clear() {
    reset();
    _bonus = 0;
    gameIsWon = false;
  }

  void calcNewFood() {
    int currNewFood = _newBonus;
    int potentialNewFood = foodOnReset();
    if (currNewFood < potentialNewFood) {
      _newBonus = potentialNewFood;
    }
  }

  int foodOnReset() {
    return (_totalClicks / data.bonusCost).floor();
  }

  String displayTotalClicks() {
    return Constants.displayDoubleNoDecimal(_totalClicks);
  }

  bool hasSufficientClicks(double amount) {
    return _totalClicks >= amount;
  } 

  double getTotalClicksPerSecond() {
    return Constants.roundToOneDecimal(_getTotalClicksPerSecond());
  }

  double _getTotalClicksPerSecond() {
    double total = 0.0;
    for (Clicker clicker in clickers) {
      total += clicker.getCurrClickRate(getBonus().toDouble());
    }
    return total;
  }

  String displayBonus() {
    return Constants.displayInt(_bonus);
  }

  String displayNewBonus() {
    return Constants.displayInt(_newBonus);
  }

  num getClickersClicksPerSecond(Clicker clicker) {
    return clicker.getClicksPerSecond(getBonus().toDouble());
  }

  num getClickersTotalClicksPerSecond(Clicker clicker) {
    return Constants.roundToDecimal((getClickersClicksPerSecond(clicker) * clicker.quantity).toDouble(), 2);
  }

  bool hasAnyClickers() {
    for (Clicker clicker in clickers) {
      if (clicker.quantity > 0) {
        return true;
      }
    }
    return false;
  }

  bool isCurrGame(String key) {
    return data.saveKey == key;
  }
}