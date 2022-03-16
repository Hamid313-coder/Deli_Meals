import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filtersScreen";

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters,this.saveFilters);
 
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  
  @override
   initState(){
     _glutenFree = widget.currentFilters["gluten"];
     _lactoseFree = widget.currentFilters["lactose"];
     _vegetarian = widget.currentFilters["vegetarian"];
     _vegan = widget.currentFilters["vegan"];
     super.initState();

  }

  Widget filtersSwitches(
      bool val, String swTitle, String swSubTitle, Function swFunc) {
    return SwitchListTile(
        title: Text(swTitle),
        subtitle: Text(swSubTitle),
        value: val,
        onChanged: swFunc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () {
              final selectedFilters = {
                "gluten": _glutenFree,
                "lactose": _lactoseFree,
                "vegetarian": _vegetarian,
                "vegan": _vegan,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your meal selection!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Expanded(
            child: ListView(
              children: [
                filtersSwitches(_glutenFree, "Gluten-free",
                    "only include Gluten-free meal.", (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                filtersSwitches(_lactoseFree, "Lactose-free",
                    "only include Lactose-free meal.", (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                filtersSwitches(
                    _vegetarian, "Vegetarian", "only include vegetarian meal.",
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                filtersSwitches(_vegan, "Vegan", "only include vegan meal.",
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
