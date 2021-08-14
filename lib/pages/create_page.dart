import 'package:flutter/material.dart';
import 'package:google_sign_in/pages/login_page.dart';
import 'package:google_sign_in/service/methods.dart';

import 'home_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Page"),
      ),
      body: _isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(children: [
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
                    "Create Account to Continue!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Name", Icons.person, _name)),
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
                      .push(MaterialPageRoute(builder: (_) => LoginPage())),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            _isLoading = true;
          });
          createAccount(_name.text, _email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                _isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
              print("Login Successful");
            } else {
              print("Login Failed");
            }
          });
        } else {
          print("Iltimos bo'sh maydonlarni to'ldiring ");
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
          "Create",
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
