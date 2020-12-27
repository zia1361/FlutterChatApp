import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stream/constants/colors.dart';
import 'package:stream/Models/FirebaseServices.dart';
import 'package:stream/Models/Chat.dart';
import 'package:stream/components/appbar.dart';
import 'package:stream/components/message.dart';



class ChatRoom extends StatelessWidget {

  static String Id = "ChatRoom";
  final String userId;
  final String friendId;
  ChatRoom({this.userId, this.friendId});
  ScrollController _scrollController = new ScrollController(keepScrollOffset: true);


  TextEditingController _textController = TextEditingController();

  String message = "";

  bool shouldRevers = false;
  @override
  Widget build(BuildContext context) {
    if(_scrollController.hasClients){
      print("yes clients");
    }
    print(_scrollController.hasClients);
    String chatId;
    if(userId.compareTo(friendId) < 0){
      chatId = userId+friendId;
    }else if(friendId.compareTo(userId) < 0){
      chatId = friendId+userId;
    }
    print(chatId);

    return Stack(
      children: [
    Container(
    decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage("assets/bg.jpg"), fit: BoxFit.fill)
    ),
    ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar("CHAT ROOM", primaryColor, true, context),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseServices().getMessageList(chatId),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Center(child: new CircularProgressIndicator(strokeWidth: 3.0,));
                    }else{
                      List<Chat> messageList = snapshot.data;
                      // shouldRevers = true;
                      print(MediaQuery.of(context).size.height/60);
                      print(messageList.length);
                      if(MediaQuery.of(context).size.height/60 < messageList.length){
                        print("should reverse");
                        shouldRevers = true;
                        messageList = messageList.reversed.toList();
                      }else{
                        // messageList = messageList.reversed.toList();
                        print("shouldn't reverse");
                        shouldRevers = false;
                      }


                      // if (_scrollController.hasClients){
                      //   print("has clients");
                      //   if(_scrollController.position.maxScrollExtent > 0){
                      //     print("should reverse");
                      //     shouldRevers = true;
                      //     messageList = messageList.reversed.toList();
                      //
                      //   } else{
                      //     print("shouldn't reverse");
                      //     shouldRevers = false;
                      //   }
                      //   // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
                      //   //     curve: Curves.linear, duration: Duration (milliseconds: 500));
                      // }
                      if(messageList.length > 0){
                        for(var oMessage in messageList){
                          if(oMessage.senderId != userId){
                            FirebaseServices().markMsgAsSeen(chatId, oMessage.id);
                          }
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          reverse: shouldRevers,
                          itemCount: messageList.length,
                          itemBuilder: (_, int index) => Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Message(chatId,messageList[index].id.toString(), messageList[index].message, messageList[index].senderId == userId ? true : false,
                                messageList[index].hasSeen
                              )
                          ),
                        );

                      }


                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(child: Text("Start your chat with first message. All messages are private.", style: TextStyle(color: Colors.yellow),
                              textAlign: TextAlign.center,
                            ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),

                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
              Container(
                height: 45.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0, top: 2.0),
                      child: TextField(
                        controller: _textController,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 2.0, top: 2.0, left: 8.0),
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0), ),

                          ),
                          filled: true,

                          hintStyle: new TextStyle(color: Colors.white),
                          hintText: "Type message",
                          fillColor: primaryColor,

                        ),

                        autofocus: false,
                        onChanged: (value){
                          message = value;
                        },
                      ),
                    )),
                    IconButton(icon: Icon(Icons.send_rounded, color: secondayColor,), onPressed: (){
                      if(message != null && message.trim() != ""){
                        FirebaseServices().addMessage(DateTime.now(), message.trim(), userId, friendId, chatId);
                        _textController.text = "";
                        message = "";
                      }

                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
