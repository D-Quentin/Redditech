import "dart:convert";
import "package:redditech/main.dart";
import "package:flutter/material.dart";
import "package:redditech/secret.dart";
import "package:redditech/api_request.dart";
import "package:flutter_webview_plugin/flutter_webview_plugin.dart";

class LoginView extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginView> {
  LoginState() {
    this.srct = Secret();
    this.clientId = this.srct.getClientID();
    this.redirectUrl = this.srct.getRedirectUri();
    this.randomString = this.srct.getRandomString();
    this.posturl =
        "https://www.reddit.com/api/v1/authorize.compact?client_id=$clientId&response_type=code&state=$randomString&redirect_uri=$redirectUrl&duration=permanent&scope=identity mysubreddits subscribe vote read account";
  }
  String code = "";
  late Secret srct;
  late String posturl;
  bool webview = true;
  String clientId = "";
  String redirectUrl = "";
  String randomString = "";
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

  retrieveToken() async {
    await api.requestToken(this.srct).then((String str) {
      if (str.contains("access_token")) {
        Map<dynamic, dynamic> tags = jsonDecode(str);
        this.srct.setToken(tags["access_token"]);
        this.srct.setExpire(tags["expires_in"]);
        this.srct.setRefresh(tags["refresh_token"]);
        this.setState(() {
          webview = false;
        });
      } else {
        this.setState(() {
          webview = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      // User accepted access and everything went right
      if (url.contains("state=$randomString") && url.contains("code=")) {
        code = url.substring(url.indexOf("code=") + 5);
        code = code.substring(0, code.length - 2);
        srct.setCode(code);
        retrieveToken();
        // TODO - User refused access
      } else if (url.contains("access_denied")) {
        // TODO - Error of all kind
      } else {}
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
