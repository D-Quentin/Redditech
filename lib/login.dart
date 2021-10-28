import 'package:redditech/api_request.dart';
import "package:redditech/main.dart";
import "package:flutter/material.dart";
import "package:redditech/secret.dart";
import "package:flutter_webview_plugin/flutter_webview_plugin.dart";

class LoginView extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginView> {
  LoginState() {
    this.srct = Secret();
    this.client_id = this.srct.getClientID();
    this.redirect_url = this.srct.getRedirectUri();
    this.random_string = this.srct.getRandomString();
    this.posturl =
        "https://www.reddit.com/api/v1/authorize.compact?client_id=$client_id&response_type=token&state=$random_string&redirect_uri=$redirect_url&scope=identity mysubreddits subscribe vote account";
  }
  String code = "";
  late Secret srct;
  late String posturl;
  bool webview = true;
  String client_id = "";
  String redirect_url = "";
  String random_string = "";
  APIRequest api = APIRequest();
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  Widget getBody() {
    switch (this.webview) {
      case (true):
        return (WebviewScaffold(url: posturl));
      case (false):
        this.flutterWebViewPlugin.close();
        return RedditechHomePage(this.srct);
      default:
        return (WebviewScaffold(url: posturl));
    }
  }

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("state=$random_string") &&
          url.contains("access_token=")) {
        List data = url.split("&");
        srct.setToken(data[0].substring(data[0].indexOf("access_token=") + 13));
        srct.setExpire(
            int.parse(data[3].substring(data[3].indexOf("expires_in=") + 11)));
        this.setState(() {
          webview = false;
        });
      } else if (url.contains("access_denied")) {
        this.setState(() {
          webview = true;
        });
      }
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
