import 'package:flutter/material.dart';
import 'package:stream/Models/FirebaseServices.dart';

import 'package:stream/constants/colors.dart';
import 'package:stream/functions/functions.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  String number;
  String name;
  @override
  Widget build(BuildContext context) {
    print("called build");
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/bg2.jpg"), fit: BoxFit.fill)
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text("+92 ", style: TextStyle(color: myMessaage),),
                    Expanded(child: NumberBox("Enter your Phone No.")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: NameBox("Enter your Name")),
                  ],
                ),
              ),
              MaterialButton(onPressed: (){
                print(number);
                print(name);
                if(name != null && number != null){
                  FirebaseServices().addUser(name, number);
                  SetPrefrences(name, number, context);
                }
              },
                color: myMessaage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Next", style: TextStyle(color: Colors.white),),
                    Icon(Icons.navigate_next, color: Colors.white,)
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget NumberBox(String hintText){
    return TextField(
      keyboardType: TextInputType.number,
      controller: _controller1,
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 2.0, top: 2.0, left: 8.0),
        border: new UnderlineInputBorder(

          borderSide: BorderSide(color: Colors.white, width: 3),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: myMessaage, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: myMessaage, width: 3.0),
        ),
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey),
        hintText: hintText,
        fillColor: Colors.transparent,
      ),
      onChanged: (value){
        number = value;
      },
    );
  }
  Widget NameBox(String hintText){
    return TextField(
      keyboardType: TextInputType.text,
      controller: _controller2,
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 2.0, top: 2.0, left: 8.0),
        border: new UnderlineInputBorder(

          borderSide: BorderSide(color: Colors.white, width: 3),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: myMessaage, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0))
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: myMessaage, width: 3.0),
        ),
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey),
        hintText: hintText,
        fillColor: Colors.transparent,
      ),
      onChanged: (value){
        name = value;
      },
    );
  }
}
