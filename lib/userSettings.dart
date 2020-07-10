import 'dart:convert';

class UserSettings {
  Map _idAndFavorite = <String, bool>{};
  void addFavorite(int index){
    _idAndFavorite['$index'] = true;
  }
  void removeFavorite(int index){
    _idAndFavorite.remove('$index');
  }
  String toJson(){
    return json.encode(_idAndFavorite);
  }

  void fromJson(String value){
    _idAndFavorite = json.decode(value);
  }
  bool checkFavorite(int index){
    if(_idAndFavorite['$index'] != null){
      return true;
    }
    return false;
  }
}

UserSettings userSettings = UserSettings();