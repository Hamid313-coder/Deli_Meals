import 'package:flutter/material.dart';
import '../dummy_data.dart.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/MealDetailScreen";
  final Function _toggleFavorites;
  final Function _isFavorite;

  const MealDetailScreen(this._toggleFavorites, this._isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Text(text, style: Theme.of(context).textTheme.title));
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 190,
      width: 320,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => mealId == meal.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Card(
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index])),
                      color: Theme.of(context).accentColor,
                    ),
                itemCount: selectedMeal.ingredients.length)),
            buildSectionTitle(context, "Steps"),
            buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text("# ${index + 1}"),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        Divider(),
                      ],
                    ),
                itemCount: selectedMeal.steps.length))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: _isFavorite(mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
      onPressed: () => _toggleFavorites(mealId),
      )
    );
  }
}
