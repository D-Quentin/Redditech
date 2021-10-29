import "package:redditech/login.dart";
import "package:flutter/material.dart";
import "package:redditech/secret.dart";
import 'package:redditech/menu/feed_page.dart';
import "package:redditech/api_request.dart";
import "package:redditech/menu/settings.dart";

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
  APIRequest api_request = APIRequest();

  void _onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  Widget getBody() {
    switch (this.selectedIndex) {
      case 0:
        return NewFeedPageWidget(this.secret);
      case 1:
        return TopFeedPageWidget(this.secret);
      case 2:
        return HotFeedPageWidget(this.secret);
      case 3:
        return SubredditSearchWidget(secret);
      case 4:
        return SubredditSettingsWidget(secret);
      default:
        return FeedPageWidget(this.secret, FeedPage.new_);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Redditech")),
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this.selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.fiber_new_rounded), label: "New"),
            BottomNavigationBarItem(
                icon: Icon(Icons.align_vertical_bottom_rounded), label: "Top"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_rounded), label: "Hot"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: "Settings")
          ],
          onTap: (int index) {
            this._onTapHandler(index);
          }),
    );
  }
}

class NewFeedPageWidget extends StatelessWidget {
  NewFeedPageWidget(this.secret);

  final Secret secret;

  @override
  Widget build(BuildContext context) {
    return (FeedPageWidget(secret, FeedPage.new_));
  }
}

class TopFeedPageWidget extends StatelessWidget {
  TopFeedPageWidget(this.secret);

  final Secret secret;

  @override
  Widget build(BuildContext context) {
    return (FeedPageWidget(secret, FeedPage.top_));
  }
}

class HotFeedPageWidget extends StatelessWidget {
  HotFeedPageWidget(this.secret);

  final Secret secret;

  @override
  Widget build(BuildContext context) {
    return (FeedPageWidget(secret, FeedPage.hot_));
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
