import 'dart:math';
import 'dart:ui';

import 'package:catalog/style.dart';
import 'package:flutter/material.dart';

Map idAndProductSet1() {
  final _idAndProductTest = <int, Product>{};
  _idAndProductTest[5] = Product(
    'https://thumbs.dreamstime.com/b/%D1%81%D1%8B%D1%80-%D0%B3%D0%B0%D1%83-%D0%B0-%D0%BD%D0%B0-%D0%B1%D0%B5-%D0%BE%D0%BC-%D0%B2%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B5-80905784.jpg',
    'Сыр гауда',
    500,
    '1кг',
    4.0,
    12,
    'Пищевой продукт, получаемый из сыропригодного молока и что-нибудь ещё',
    'Молочный рай',
    3,
  );
  _idAndProductTest[10] = Product(
    'https://thumbs.dreamstime.com/b/%D0%BC%D0%BE%D0%BB%D0%BE%D0%BA%D0%BE-%D0%B2-%D1%81%D1%82%D0%B5%D0%BA%D0%BB%D1%8F%D0%BD%D0%BD%D0%BE%D0%BC-%D0%BA%D1%83%D0%B2%D1%88%D0%B8%D0%BD%D0%B5-26087963.jpg',
    'Молоко 5%',
    100,
    '1л',
    5.0,
    12,
    'Пищевой продукт, получаемый из сыропригодного молока и что-нибудь ещё',
    'Молочный рай',
    2,
  );
  _idAndProductTest[20] = Product(
    'https://image.freepik.com/free-photo/_88281-1473.jpg',
    'Сметана',
    300,
    '1кг',
    4.5,
    20,
    'Пищевой продукт, получаемый из сыропригодного молока и что-нибудь ещё',
    'Молочный рай',
    2,
  );
  _idAndProductTest[22] = Product(
    'https://st.depositphotos.com/1003814/3170/i/950/depositphotos_31705387-stock-photo-raw-chicken-legs-on-white.jpg',
    'Куриные ножки',
    220,
    '1кг',
    2.2,
    20,
    'Пищевой продукт, получаемый из курицы и только курицы',
    'Мясное королевство',
    4,
  );
  _idAndProductTest[25] = Product(
    'https://media.istockphoto.com/photos/raw-chicken-wings-isolated-on-white-background-picture-id489521554',
    'Куриные крылышки',
    250,
    '1кг',
    4.2,
    20,
    'Пищевой продукт, получаемый из курицы и только курицы',
    'Мясное царство',
    4,
  );
  _idAndProductTest[28] = Product(
    'https://shkolazhizni.ru/img/content/i103/103996_big.jpg',
    'Курица',
    150,
    '1кг',
    4.9,
    20,
    'Пищевой продукт, получаемый из курицы и только курицы',
    'Поросячье счастье рядом',
    4,
  );
  //var test = _idAndProductTest[2];
  //print(test.title);
  return _idAndProductTest;
}

Map idAndProductSet(){
  final _idAndProductTest = <int, Product>{};

  for(var i = 0; i < 100; i++){

    final category = Random().nextInt(3) + 2;
    String title;
    String imageUrl;
    switch(category){
      case 2 : title = 'Молочный продукт'; imageUrl = 'https://thumbs.dreamstime.com/b/%D0%BC%D0%BE%D0%BB%D0%BE%D0%BA%D0%BE-%D0%B2-%D1%81%D1%82%D0%B5%D0%BA%D0%BB%D1%8F%D0%BD%D0%BD%D0%BE%D0%BC-%D0%BA%D1%83%D0%B2%D1%88%D0%B8%D0%BD%D0%B5-26087963.jpg';
      break;
      case 3 : title = 'Сыр'; imageUrl = 'https://thumbs.dreamstime.com/b/%D1%81%D1%8B%D1%80-%D0%B3%D0%B0%D1%83-%D0%B0-%D0%BD%D0%B0-%D0%B1%D0%B5-%D0%BE%D0%BC-%D0%B2%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B5-80905784.jpg';
      break;
      case 4 : title = 'Мясо'; imageUrl = 'https://st.depositphotos.com/1003814/3170/i/950/depositphotos_31705387-stock-photo-raw-chicken-legs-on-white.jpg';
      break;
      default : title = 'Неизвестный продукт'; imageUrl = 'https://wizardgum.ru/catalog/view/theme/default/image/messages/404.png';
      break;
    }


    _idAndProductTest[i] = Product(
      imageUrl,
      i ==1 ? 'Невероятно длинный заголовок, который нужно проверить': title,
      Random().nextInt(500) + 100,
      '1кг',
      double.parse(Random().nextDouble().toStringAsFixed(1)) * 4 + 1,
      Random().nextInt(50),
      'Пищевой продукт, получаемый из сыропригодного молока и что-нибудь ещё',
      'Молочный рай',
      category,
    );

  }

  return _idAndProductTest;
}

Map numberAndIdSet(Map idAndProduct) {
  final _numberAndIdTest = <int, int>{};

  //print(idAndProduct.keys.elementAt(2));

  for (var i = 0; i < idAndProduct.length; i++) {
    _numberAndIdTest[i] = idAndProduct.keys.elementAt(i);
  }
  //print(_numberAndIdTest.keys);
  return _numberAndIdTest;
}

class Product {

  Product(this.imageUrl, this.title, this.price, this.unitOfMeasurement, this.rating, this.numberOfRatings, this.description, this.from, this.category){
    colorOfRating = setColor();
  }

  String imageUrl;
  String title;
  int price;
  String unitOfMeasurement;
  double rating;
  int numberOfRatings;
  Color colorOfRating;
  String description;
  String from;
  int category;

  Color setColor() {
    if (rating > 4.4) {
      return veryGoodColor;
    }
    if (rating > 3.4) {
      return goodColor;
    }
    return Colors.grey;
  }
}
