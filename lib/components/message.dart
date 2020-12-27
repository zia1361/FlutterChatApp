import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream/constants/colors.dart';

Widget Message(String chatId, String id, String message, bool isMe, bool hasSeen){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          color: isMe ? secondayColor : otherMessage,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.0),
          bottomLeft:  Radius.circular(15.0), topLeft:  isMe ? Radius.circular(15.0): Radius.circular(0.0),
          topRight:   isMe ? Radius.circular(0.0): Radius.circular(15.0)
          )
        ),
        child: GestureDetector(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(message, style: messageText),
              isMe ? Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Stack(children: hasSeen ? [
                  Icon(Icons.check, color: hasSeenColor, size: 14.0,),Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.check, color: hasSeenColor, size: 12.0),
                  )
                ] : [Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(Icons.check, color: sentColor, size: 12.0,),
                )],),
              ) : Container(width: 0.0, height: 0.0,)
            ],
          ),
        ), onTap: (){
          print("Id: $id");

        },),
      ),
    ],
  );
}