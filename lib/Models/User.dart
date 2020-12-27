
class User{
   String name;
   String phoneNumber;
  static User oUser;

  User({this.name, this.phoneNumber});

  User.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        phoneNumber = parsedJSON['phoneNumber'];

}