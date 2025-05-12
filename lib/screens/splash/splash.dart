import 'package:flutter/material.dart';
import 'package:hrm_project/screens/login/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();
    _checkAuthStatus(context);
  }
  void _checkAuthStatus(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2));

    
  
  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
         child:SpinKitFadingCircle(
          itemBuilder: (_, int index) {
          return DecoratedBox(
          decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
          ),
         );
       },
         )
      ),
    );
  }
}

