import 'package:catalog/home_page.dart';
import 'package:catalog/userSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Если ты запускаешь какую-то асинхронную функцию в main, которая как-то инициализирует твое приложение - сделай и main асинхронным, и запускай приложение после инициализации
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUserSettings().whenComplete(() => runApp(MyApp()));
}

Future<void> setUserSettings() async {
  // final
  final pref = await SharedPreferences.getInstance();
  // Присвоение 'null', если pref вернет обычный null - не имеет смысла, можно было не усложнять + сделай ее final
//  var userSettingsJson = await pref.getString('userSettings') ?? 'null'; // await не нужен, тк pref.getString возвращает String, а не Future<String>
  final userSettingsJson = pref.getString('userSettings');
  if (userSettingsJson != null) {
    userSettings.fromJson(userSettingsJson);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Каталог',
      home: MyHomePage(),
    );
  }
}

