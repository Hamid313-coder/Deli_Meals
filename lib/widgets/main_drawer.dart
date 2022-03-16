import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget buildListTile(String title, IconData icon, Function func) {
    return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(title,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
        onTap: func,
            );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: Text("Cooking Up!",
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                )),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 20),
          buildListTile("Meals", Icons.restaurant, (){
            Navigator.of(context).pushReplacementNamed("/");
          }),
          buildListTile("Filters", Icons.settings, (){
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          })
        ],
      ),
    );
  }
}
