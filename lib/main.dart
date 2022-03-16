import 'package:flutter/material.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/detail_meal_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart.dart';
import './models/meal.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    "gluten": false,
    "lactose": false,
    "vegetarian": false,
    "vegan": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId){
   final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
   if(existingIndex >=0){
     setState(() {
          _favoriteMeals.removeAt(existingIndex);  
     });
     
   }else{
     setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
     });
   }
  }

  bool _isFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

 void _setFilters (Map<String, bool> filterData){
          setState(() {
            filters = filterData;
            _availableMeals = DUMMY_MEALS.where((meal){
              if(filters["gluten"] && !meal.isGlutenFree){
                return false;
              }
              if(filters["lactose"] && !meal.isLactoseFree){
                return false;
              }
              if(filters["vegetarian"] && !meal.isVegetarian){
                return false;
              }
              if(filters["vegan"] && !meal.isVegan){
                return false;
              }
              return true;
            }).toList();
          });
 }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 224, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.normal),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(filters,_setFilters),
      },
      onUnknownRoute: (setting){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
