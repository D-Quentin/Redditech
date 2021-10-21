import 'dart:io';
// import 'package:redditech/main.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  int selectedIndex = 1;
  bool isLoggedIn = false;

  void _onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  Widget getBody() {
    switch (this.selectedIndex) {
      case 0:
        return _LoginView();
      case 1:
        return _RegisterWebView();
      default:
        return _LoginView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this.selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.login_rounded), label: "Login"),
            BottomNavigationBarItem(
                icon: Icon(Icons.app_registration_rounded), label: "Register"),
          ],
          onTap: (int index) {
            this._onTapHandler(index);
          }),
    );
  }
}

class _LoginView extends StatelessWidget {
  _LoginView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Center(child: Text("test"));
  }
}

class _RegisterWebView extends StatelessWidget {
  _RegisterWebView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "https://www.reddit.com/register",
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

// class _LoginViewState extends State<LoginView> {
//   bool isLoggedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: "https://www.reddit.com/login",
//       javascriptMode: JavascriptMode.unrestricted,
//     );
//   }
// }
