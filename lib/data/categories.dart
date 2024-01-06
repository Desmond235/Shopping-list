import 'package:flutter/material.dart';
import 'package:shopping_list/models/category.dart';

var categories = {
  Categories.vegetables: Category(
    "vegetables",
    Colors.lightBlue,
  ),
  Categories.fruit: Category(
    'fruit',
    Colors.green
  ),
  Categories.meat: Category(
    'meat',
    Colors.red
  ),
  Categories.diary: Category(
    'diary',
    const Color.fromARGB(255, 0, 208, 255),
  )
};
