import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({super.key, required this.groceryItem});

  final GroceryItem groceryItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 20,
        width: 20,
        color: groceryItem.category.color,
      ),
      title: Text(groceryItem.name),
      trailing: Text(
        groceryItem.quantity.toString(),
      ),
    );
  }
}
