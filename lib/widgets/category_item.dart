import 'package:flutter/material.dart';

import '../screens/category_meals.dart';


class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void selectCatgeory(ctx) {
    Navigator.of(ctx).pushNamed(CategoryMeals.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCatgeory(context),
      child: Container(
        child: Center(
            child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        )),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color.withOpacity(0.7),
              color,
            ]),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
