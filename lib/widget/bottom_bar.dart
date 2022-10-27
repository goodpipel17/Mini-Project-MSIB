import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/homepage.dart';
import 'package:recipe_app/Screens/input_recipe.dart';
import 'package:recipe_app/Screens/kalori_page.dart';

class bottom_bar extends StatefulWidget {
  const bottom_bar({super.key});

  @override
  State<bottom_bar> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<bottom_bar> {
  int _botombarnavindex = 0;

  List<Widget> page = [
    new homepage(),
    new input_recipe(),
    new kalkulator_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: page[_botombarnavindex],
      bottomNavigationBar: ConvexAppBar(
        cornerRadius: 25,
        color: Colors.greenAccent,
        activeColor: Colors.greenAccent.shade700,
        backgroundColor: Colors.white,
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.add),
          TabItem(icon: Icons.calculate),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            _botombarnavindex = i;
          });
        },
      ),
    );
  }
}
