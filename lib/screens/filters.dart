import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = 'filters';

  final Function setfilters;
  final Map<String, bool> currentFilters;

  Filters(this.currentFilters ,this.setfilters);
  @override
  _FiltersState createState() => _FiltersState();
}


class _FiltersState extends State<Filters> {
  var _isVegan = false;
  var _isVegetarian = false;
  var _isGlutenFree = false;
  var _isLactoseFree = false;

  @override
  initState() {
    _isVegan = widget.currentFilters['vegan'] as bool;
    _isVegetarian = widget.currentFilters['vegetarian'] as bool;
    _isLactoseFree = widget.currentFilters['lactose'] as bool;
    _isGlutenFree = widget.currentFilters['gluten'] as bool;
    super.initState();
  }


  Widget buildSwitchListTile(
    bool value,
    String title,
    String description,
    Function updateVal,
  ) {
    return SwitchListTile(
      value: value,
      title: Text(title),
      subtitle: Text(description),
      onChanged: (val) => updateVal(val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Adjust your meal selection!',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  _isVegan,
                  'Vegan',
                  'Only include vegan meals',
                  (val) => setState(() => _isVegan = val),
                ),
                buildSwitchListTile(
                  _isVegetarian,
                  'Vegetarian',
                  'Only include Vegetarian meals',
                  (val) => setState(() => _isVegetarian = val),
                ),
                buildSwitchListTile(
                  _isGlutenFree,
                  'Gluten-Free',
                  'Only include gluten-free meals',
                  (val) => setState(() => _isGlutenFree = val),
                ),
                buildSwitchListTile(
                  _isLactoseFree,
                  'Lactose-Free',
                  'Only include lactose-free meals',
                  (val) => setState(() => _isLactoseFree = val),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedFilters = {
                        'gluten': _isGlutenFree,
                        'lactose': _isLactoseFree,
                        'vegan': _isVegan,
                        'vegetarian': _isVegetarian,
                      };
                      widget.setfilters(selectedFilters);
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
