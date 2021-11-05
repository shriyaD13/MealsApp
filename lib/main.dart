import 'package:flutter/material.dart';

import 'dummy_data.dart';
import './models/meal.dart';
import './screens/filters.dart';
import './screens/tabScreen.dart';
import './screens/mealDetail.dart';
import './screens/category_meals.dart';
import './screens/categories.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose': false,
    'vegan' : false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];


  void _setFilters(Map<String, bool> filterdata)
  {
    setState(() {
      _filters = filterdata;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten']! && !meal.isGlutenFree) return false;
        if(_filters['lactose']! && !meal.isLactoseFree) return false;
        if(_filters['vegan']! && !meal.isVegan) return false;
        if(_filters['vegetarian']! && !meal.isVegetarian) return false;
        return true;
      }).toList();
      
     });
  }

  void _toggleFav(String id) {
    final mealIdx = _favouriteMeals.indexWhere((meal) => meal.id == id);

    if(mealIdx >= 0 ) {
      setState(() {
        _favouriteMeals.removeAt(mealIdx);
      });
    } else{
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
      });
    }
  }

  bool _isFav(String id){
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      routes: {
        '/' : (ctx) => TabScreen(_favouriteMeals),
        CategoryMeals.routeName:(ctx) => CategoryMeals(_availableMeals),
        MealDetail.routeName: (ctx) => MealDetail(_toggleFav,_isFav),
        Filters.routeName : (ctx) => Filters(_filters,_setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => Categories());
      },
    );
  }
}
