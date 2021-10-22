import "package:redditech/main.dart";
import "package:flutter/material.dart";
import "package:redditech/secret.dart";
import "package:flutter_webview_plugin/flutter_webview_plugin.dart";

class LoginView extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginView> {
  bool webview = true;
  String random_str = "";
  String token = "";
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final String posturl =
      "https://www.reddit.com/api/v1/authorize.compact?client_id=$client_id&response_type=code&state=test&redirect_uri=http://localhost:8080/&duration=permanent&scope=identity mysubreddits subscribe vote";

  Widget getBody() {
    switch (this.webview) {
      case (true):
        return (WebviewScaffold(url: posturl));
      case (false):
        return RedditechHomePage(this.token);
      default:
        return (WebviewScaffold(url: posturl));
    }
  }

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("code=") && !url.contains("error=access_denied")) {
        token = url.substring(url.indexOf("code=") + 5, url.indexOf("#"));
        flutterWebViewPlugin.close();
        this.setState(() {
          webview = false;
        });
      } else if (url.contains("error=access_denied"))
        this.setState(() {
          webview = true;
        });
    });
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return this.getBody();
  }
}

// class _LoginViewState extends State<LoginView> {
//   final username = TextEditingController();
//   final password = TextEditingController();

//   getItemAndNavigate(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => _LoginRequest(
//           username.text,
//           password.text,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Container(
//                 width: 280,
//                 padding: const EdgeInsets.only(top: 120.0, bottom: 5.0),
//                 child: TextField(
//                   controller: username,
//                   decoration: InputDecoration(hintText: 'Username'),
//                 )),
//             Container(
//                 width: 280,
//                 padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
//                 child: TextField(
//                   controller: password,
//                   decoration: InputDecoration(hintText: 'Password'),
//                 )),
//             TextButton(
//               child: Text('Login'),
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//               ),
//               onPressed: () {
//                 getItemAndNavigate(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

