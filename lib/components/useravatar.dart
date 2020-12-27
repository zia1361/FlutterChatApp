import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream/constants/colors.dart';
import 'package:stream/screens/chatroom.dart';
Widget UserAvatar(String name, String number, context, String user){
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: GestureDetector(
      onTap: (){
        print(number);
        print(user);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(userId: user, friendId: number,)));
      },
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
            backgroundColor: primaryColor,
              radius: 30,
              child: Icon(Icons.person, color: bgColor,)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(color: Colors.white)),

                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide( //                   <--- left side
              color: primaryColor,
              width: 1.0,
            ),
          )
        ),
      ),
    ),
  );
}