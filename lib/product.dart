import 'dart:ui';

import 'package:flutter/material.dart';

Map idAndProductSet() {
  var _idAndProductTest = <int, Product>{};
  _idAndProductTest[0] = Product(
    'https://thumbs.dreamstime.com/b/%D1%81%D1%8B%D1%80-%D0%B3%D0%B0%D1%83-%D0%B0-%D0%BD%D0%B0-%D0%B1%D0%B5-%D0%BE%D0%BC-%D0%B2%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B5-80905784.jpg',
    'Сыр гауда',
    500,
    '1кг',
    4.0,
    12,
    'Пищевой продукт, получаемый из сыропригодного молока и что-нибудь ещё',
    'Молочный рай',
  );
  _idAndProductTest[1] = Product(
    'https://thumbs.dreamstime.com/b/%D0%BC%D0%BE%D0%BB%D0%BE%D0%BA%D0%BE-%D0%B2-%D1%81%D1%82%D0%B5%D0%BA%D0%BB%D1%8F%D0%BD%D0%BD%D0%BE%D0%BC-%D0%BA%D1%83%D0%B2%D1%88%D0%B8%D0%BD%D0%B5-26087963.jpg',
    'Молоко 5%',
    100,
    '1л',
    5.0,
    12,
    'Пищевой продукт, получаемый из сыропригодного молока и что-нибудь ещё',
    'Молочный рай',
  );
  _idAndProductTest[2] = Product(
    'https://image.freepik.com/free-photo/_88281-1473.jpg',
    'Сметана',
    300,
    '1кг',
    4.5,
    20,
    'Пищевой продукт, получаемый из сыропригодного молока и что-нибудь ещё',
    'Молочный рай',
  );
  //var test = _idAndProductTest[2];
  //print(test.title);
  return _idAndProductTest;
}

class Product {
  String imageUrl;
  String title;
  int price;
  String unitOfMeasurement;
  double rating;
  int numberOfRatings;
  Color colorOfRating;
  String description;
  String from;

  Product(
    String _imageUrl,
    String _title,
    int _price,
    String _unitOfMeasurement,
    double _rating,
    int _numberOfRatings,
    String _description,
    String _from,
  ) {
    imageUrl = _imageUrl;
    title = _title;
    price = _price;
    unitOfMeasurement = _unitOfMeasurement;
    rating = _rating;
    numberOfRatings = _numberOfRatings;
    colorOfRating = setColor();
    description = _description;
    from = _from;
  }

  Color setColor() {
    if (rating > 4.4) {
      return Color(0xFF4aa73a);
    }
    if (rating > 3.4) {
      return Color(0xFFd0a108);
    }
    return Colors.grey;
  }
}
