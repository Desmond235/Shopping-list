import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widget/grocery_list.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceris'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GroceryListItem(groceryItem: groceryItem[index]);
        },
        itemCount: groceryItem.length,
        
      ),
    );
  }
}
