import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream/Models/User.dart';
import 'package:stream/components/useravatar.dart';
import 'package:stream/components/appbar.dart';
import 'package:stream/constants/colors.dart';
class Users extends StatefulWidget {
  final String user;
  Users({this.user});
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar("USERS", primaryColor, false, context),
      body: FutureBuilder(
          future:  getData() ,
          builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot){
            if(snapshot.hasData){
              print(snapshot.data.map((e) => User.fromJson(e.data())).toList());
              List<Widget> oAvatars = [];
              for(var oUser in snapshot.data.map((e) => User.fromJson(e.data())).toList()){
                if(widget.user != oUser.phoneNumber)
                  oAvatars.add(UserAvatar(oUser.name, oUser.phoneNumber, context, widget.user));
              }
              if(oAvatars.length > 0){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: oAvatars,
                );
              }else{
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child: Text("Currently No Users Joined this App.", style: TextStyle(color: Colors.yellow),
                      textAlign: TextAlign.center,
                    ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),

                      ),
                    ),
                  ),
                );
              }
            }else{
              return Center(child: new CircularProgressIndicator());
            }


            return Container();
          }),
    );
  }

  Future<List<DocumentSnapshot>> getData() async {
    FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;
    QuerySnapshot qn = await _fireStoreDataBase
        .collection("users")
        .get();
    _fireStoreDataBase.terminate();
    return qn.docs;
  }
}
