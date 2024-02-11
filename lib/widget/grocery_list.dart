import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({
    super.key,
    required this.groceryItem,
    required this.onRemoveItem,
  });

  final GroceryItem groceryItem;
  final void Function(DismissDirection direction) onRemoveItem;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // background: Container(
      //   color: Theme.of(context).colorScheme.errorContainer,
      //   child: const ListTile(
      //     leading: Icon(Icons.delete, color: Colors.white,),
      //     trailing: Icon(Icons.delete, color: Colors.white),
      //   ),
      // ),
      key: ValueKey(groceryItem.id),
      onDismissed: onRemoveItem,
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
