import 'package:flutter/material.dart';

import 'home.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text.rich(TextSpan(
                  text: 'Rocket',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  children: <InlineSpan>[
                    TextSpan(
                      text: ' Movies',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                )),
              ),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}
