import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({
    super.key,
    required this.groceryItem,
    required this.onRemoveItem,
  });

  final GroceryItem groceryItem;
  final void Function() onRemoveItem;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(groceryItem.id),
      onDismissed: (direction) {
        onRemoveItem;
      },
      child: ListTile(
        leading: Container(
          height: 20,
          width: 20,
          color: groceryItem.category.color,
        ),
        title: Text(groceryItem.name),
        trailing: Text(
          groceryItem.quantity.toString(),
        ),
      ),
    );
  }
}
