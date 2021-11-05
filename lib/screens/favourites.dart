import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class Favourites extends StatelessWidget {
  final List<Meal> favouriteMeals;

  Favourites(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    return favouriteMeals.isEmpty
        ? Center(
            child: Text('No favourites yet!'),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: favouriteMeals[index].id,
                title: favouriteMeals[index].title,
                imageUrl: favouriteMeals[index].imageUrl,
                affordability: favouriteMeals[index].affordability,
                complexity: favouriteMeals[index].complexity,
                duration: favouriteMeals[index].duration,
              );
            },
            itemCount: favouriteMeals.length,
          );
  }
}
