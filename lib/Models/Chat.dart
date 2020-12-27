class Chat{
  String id;
  String message;
  String senderId;
  String receiverId;
  bool hasSeen;

  Chat({this.id, this.message, this.senderId, this.receiverId, this.hasSeen});

  Chat.fromJson(Map<String, dynamic> parsedJSON)
      : id = parsedJSON['id'],
        message = parsedJSON['message'],
        senderId = parsedJSON['senderId'],
        receiverId = parsedJSON['receiverId'],
        hasSeen = parsedJSON['hasSeen'];
}