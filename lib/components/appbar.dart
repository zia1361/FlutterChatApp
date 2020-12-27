import 'package:flutter/material.dart';
import 'package:stream/constants/colors.dart';

Widget CustomAppBar(String title, Color color, bool hasLeading, context){
  return AppBar(
    title: Text(title, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
    backgroundColor: color,
    centerTitle: true,
    toolbarHeight: 50.0,
    automaticallyImplyLeading: hasLeading,
    leading:  hasLeading ? IconButton(icon: Icon(Icons.arrow_back, color: iconColor,), onPressed: (){Navigator.pop(context);},): null,
  );
}