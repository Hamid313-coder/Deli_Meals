import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals; 

  @override
  void initState() {
    super.initState();
     
  } 

  var _loadedInitData = true;

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    if(_loadedInitData){
    final routArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routArgs['id'];
    categoryTitle = routArgs['title'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    _loadedInitData = false;
    }
  }

  void _removeMeal(String mealId){
      setState(() {
        displayedMeals.removeWhere((meal) => meal.id == mealId);
      });
    }
  @override
  Widget build(BuildContext context) {
   

    
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              );
              
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
