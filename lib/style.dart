import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Оп, это я увидел уже после main с объявлениями тобой там напрямую Color(...)
// В общем стоит перенести сюда все твои цвета оттуда и использовать так же
// + смотри, что тебе скажет тут линтер
const nonColorMediumText = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
const veryGoodColor = Color(0xFF4aa73a);
const goodColor = Color(0xFFd0a108);
const shadowColor = Color(0xFFf5f5f5);
const tabBarColor = Color(0xFF47a73d);
const borderColor = Color(0xFFe2e2e2);
const lightColor = Color(0xFFf2f3f3);
const labelColor = Color(0xFFe3ffe0);
const mediumGrayTextStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFFa0a0a0));
const smallGrayTextStyle = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF9b9b9b));
const smallBlackTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);
const mediumBlackTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black);
const superSmallBlackTextStyle = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black);
const smallWhiteTextStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white);
