import "package:http/http.dart";
import "package:flutter/material.dart";
import "package:redditech/login.dart";
// import "package:redditech/http_service.dart";

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
  RedditechHomePage(this.token);

  final String token;
  @override
  RedditechHomePageState createState() => RedditechHomePageState(token);
}

class RedditechHomePageState extends State<RedditechHomePage> {
  RedditechHomePageState(this.token);

  int selectedIndex = 0;
  String token;
  String subreddit_url = "/r/subreddit";
  final Client client = Client();

  void _changeSubreddit(String subreddit) {
    setState(() {
      subreddit_url = subreddit;
    });
  }

  void _onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  Widget getBody() {
    switch (this.selectedIndex) {
      case 0:
        return _SubredditNewWidget(this.client, this.subreddit_url);
      case 1:
        return _SubredditHotWidget(this.client, this.subreddit_url);
      case 2:
        return _SubredditSearchWidget(this.client, this.subreddit_url);
      case 3:
        return _SubredditSettingsWidget();
      default:
        return _SubredditNewWidget(this.client, this.subreddit_url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$subreddit_url")),
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this.selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.fiber_new_rounded), label: "New"),
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

class _SubredditNewWidget extends StatelessWidget {
  _SubredditNewWidget(this.client, this.subreddit_url);

  final Client client;
  final String subreddit_url;

  Widget build(BuildContext context) {
    return Center(child: Text("koukou"));
  }
}

class _SubredditHotWidget extends StatelessWidget {
  _SubredditHotWidget(this.client, this.subreddit_url);

  final Client client;
  final String subreddit_url;

  Widget build(BuildContext context) {
    return Center(child: Text("Hot"));
  }
}

class _SubredditSearchWidget extends StatelessWidget {
  _SubredditSearchWidget(this.client, this.subreddit_url);

  final Client client;
  final String subreddit_url;

  Widget build(BuildContext context) {
    return Center(child: Text("Search"));
  }
}

class _SubredditSettingsWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(child: Text("Settings"));
  }
}
