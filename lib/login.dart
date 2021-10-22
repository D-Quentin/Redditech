import 'package:redditech/main.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final username = TextEditingController();
  final password = TextEditingController();

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _LoginRequest(
          usernameHolder: username.text,
          passwordHolder: password.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                width: 280,
                padding: const EdgeInsets.only(top: 120.0, bottom: 5.0),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(hintText: 'Username'),
                )),
            Container(
                width: 280,
                padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(hintText: 'Password'),
                )),
            TextButton(
              child: Text('Login'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                getItemAndNavigate(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginRequest extends StatelessWidget {
  final usernameHolder;
  final passwordHolder;

  _LoginRequest({@required this.usernameHolder, this.passwordHolder});

  Widget build(BuildContext context) {
    return RedditechHomePage();
  }
}
