import 'package:stream/constants/strings_constants.dart';
import 'package:stream/screens/register.dart';
import 'package:stream/screens/users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void IsActive(context)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getBool('isActive') ?? false){
    userLogin =  prefs.getString("number");
    if(userLogin != "")
      Navigator.push(context, MaterialPageRoute(builder: (context) => Users(user: userLogin,)));

  }else{
    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
  }
}

void SetPrefrences(String name, String phoneNumber, context)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);
  prefs.setString("number", phoneNumber);
  userLogin = phoneNumber;
  prefs.setBool("isActive", true);
  Navigator.push(context, MaterialPageRoute(builder: (context) => Users(user: phoneNumber,)));
}