import 'package:flutter/material.dart';
import 'package:google_sign_in/service/methods.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => logOut(context),
          child: Text("Log Out"),
        ),
      ),
    );
  }
}
