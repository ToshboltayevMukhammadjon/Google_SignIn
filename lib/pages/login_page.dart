import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/pages/create_page.dart';
import 'package:google_sign_in/pages/home_page.dart';
import 'package:google_sign_in/service/methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: _isLoading? Center(
        child: Container(
          height: size.height/20,
          width: size.height/20,
          child: CircularProgressIndicator(),
        ),
      )
     : SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: size.height / 10,
            ),
            Container(
              width: size.width / 1.3,
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: size.width / 1.3,
              child: Text(
                "Sign In to Continue!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "email", Icons.email, _email),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(size, "password", Icons.lock, _password)),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            customButton(size),
            SizedBox(
              height: size.height / 40,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CreatePage())),
              child: Text(
                "Create Account",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            _isLoading = true;
          });
          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Successful");
              setState(() {
                _isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            } else {
              print("Login Failed");
              setState(() {
                _isLoading = true;
              });
            }
          });
        }
      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
