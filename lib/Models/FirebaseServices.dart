import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream/Models/Chat.dart';
import 'User.dart';

class FirebaseServices {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  addUser(String name, String phoneNumber){
    var addUserData = Map<String,dynamic>();
    addUserData['name'] = name;
    addUserData['phoneNumber'] = phoneNumber;
     _fireStoreDataBase.collection('users').doc(phoneNumber).set(addUserData);

  }

  Stream<List<User>> getUserList(){

    return _fireStoreDataBase.collection('users')
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map((document) => User.fromJson(document.data()))
        .toList());
  }

  addMessage(id, String message, String senderId, String receiverId, docId){
    var addMsgData = Map<String,dynamic>();
    addMsgData['id'] = id.toString();
    addMsgData['message'] = message;
    addMsgData['senderId'] = senderId;
    addMsgData['receiverId'] = receiverId;
    addMsgData['hasSeen'] = false;
    _fireStoreDataBase.collection('chatrooms').doc(docId).collection(docId).doc(id.toString()).set(addMsgData);
  }

  Stream<List<Chat>> getMessageList(docId){

    return _fireStoreDataBase.collection('chatrooms').doc(docId).collection(docId)
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map((document) => Chat.fromJson(document.data()))
        .toList());
  }

  markMsgAsSeen(String chatId, String mesageId){
    _fireStoreDataBase.collection('chatrooms').doc(chatId).collection(chatId).doc(mesageId).update({'hasSeen': true});
  }


}