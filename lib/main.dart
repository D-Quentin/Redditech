import "package:http/http.dart";
import "package:flutter/material.dart";
import "package:redditech/login.dart";
// import "package:redditech/http_service.dart";

void main() => runApp(LoginView());

class Redditech extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Redditech",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: RedditechHomePage(
        title: "Redditech",
      ),
    );
  }
}

class RedditechHomePage extends StatefulWidget {
  RedditechHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RedditechHomePageState createState() => _RedditechHomePageState();
}

class _RedditechHomePageState extends State<RedditechHomePage> {
  int selectedIndex = 0;
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
        return _SubredditNewWidget(
            client: this.client, subreddit_url: this.subreddit_url);
      case 1:
        return _SubredditHotWidget(
            client: this.client, subreddit_url: this.subreddit_url);
      case 2:
        return _SubredditSearchWidget(
            client: this.client, subreddit_url: this.subreddit_url);
      case 3:
        return _SubredditSettingsWidget();
      default:
        return _SubredditNewWidget(
            client: this.client, subreddit_url: this.subreddit_url);
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
  _SubredditNewWidget(
      {Key? key, required this.client, required this.subreddit_url})
      : super(key: key);

  final Client client;
  final String subreddit_url;

  Widget build(BuildContext context) {
    return Center(child: Text("koukou"));
  }
}

class _SubredditHotWidget extends StatelessWidget {
  _SubredditHotWidget(
      {Key? key, required this.client, required this.subreddit_url})
      : super(key: key);

  final Client client;
  final String subreddit_url;

  Widget build(BuildContext context) {
    return Center(child: Text("Hot"));
  }
}

class _SubredditSearchWidget extends StatelessWidget {
  _SubredditSearchWidget(
      {Key? key, required this.client, required this.subreddit_url})
      : super(key: key);

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
