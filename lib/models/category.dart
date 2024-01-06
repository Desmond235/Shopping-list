import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  diary,
}

class Category {
  Category(this.name, this.color);

  final String name;
  final Color color;
}
