import 'package:flutter/material.dart';
import 'package:stream/functions/functions.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/bg3.jpg"), fit: BoxFit.fill)
      ),
    );
  }
  @override
  void didChangeDependencies(){
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    new Future.delayed(const Duration(seconds : 5));
    print("updated");
    IsActive(context);
  }
}
