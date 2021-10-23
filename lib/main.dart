import "package:http/http.dart";
import "package:redditech/login.dart";
import "package:flutter/material.dart";
import "package:redditech/secret.dart";
import 'package:redditech/api_request.dart';

void main() => runApp(Redditech());

class Redditech extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Redditech",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: LoginView(),
    );
  }
}

class RedditechHomePage extends StatefulWidget {
  RedditechHomePage(this.secret);

  final Secret secret;

  @override
  RedditechHomePageState createState() => RedditechHomePageState(secret);
}

class RedditechHomePageState extends State<RedditechHomePage> {
  RedditechHomePageState(this.secret);

  Secret secret;
  int selectedIndex = 0;
  String sub_subreddit = "";
  String data_user = "";
  APIRequest api_request = APIRequest();

  void _onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  Widget getBody() {
    switch (this.selectedIndex) {
      case 0:
        return SubredditNewWidget(this.secret);
      case 1:
        return SubredditHotWidget(this.secret);
      case 2:
        return SubredditSearchWidget(this.secret);
      case 3:
        return SubredditSettingsWidget(this.secret);
      default:
        return SubredditNewWidget(this.secret);
    }
  }

  @override
  Widget build(BuildContext context) {
    api_request.RequestUserData(this.secret).then((String result) {
      setState(() {
        data_user = result;
      });
    });
    print(data_user);
    return Scaffold(
      appBar: AppBar(title: Text("Redditech")),
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this.selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.fiber_new_rounded), label: "$sub_subreddit"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_rounded), label: "Hot"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings")
          ],
          onTap: (int index) {
            this._onTapHandler(index);
          }),
    );
  }
}

class SubredditNewWidget extends StatelessWidget {
  SubredditNewWidget(this.secret);

  final Secret secret;
  final APIRequest api_request = APIRequest();

  Widget build(BuildContext context) {
    return Center(child: Text("Salut"));
  }
}

class SubredditHotWidget extends StatelessWidget {
  SubredditHotWidget(this.secret);

  final Secret secret;

  Widget build(BuildContext context) {
    return Center(child: Text("Hot"));
  }
}

class SubredditSearchWidget extends StatelessWidget {
  SubredditSearchWidget(this.secret);

  final Secret secret;

  Widget build(BuildContext context) {
    return Center(child: Text("Search"));
  }
}

class SubredditSettingsWidget extends StatelessWidget {
  SubredditSettingsWidget(this.secret);

  final Secret secret;

  Widget build(BuildContext context) {
    return Center(child: Text("Settings"));
  }
}
