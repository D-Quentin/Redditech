import "package:http/http.dart";
import "package:redditech/login.dart";
import "package:flutter/material.dart";
import "package:redditech/secret.dart";
import 'package:redditech/api_request.dart';
import 'package:redditech/post_model.dart';

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

class SubredditSettingsWidget extends StatefulWidget {
  SubredditSettingsWidget(this.secret);

  final Secret secret;

  @override
  SubredditSettingsWidgetState createState() =>
      SubredditSettingsWidgetState(secret);
}

class SubredditSettingsWidgetState extends State<SubredditSettingsWidget> {
  SubredditSettingsWidgetState(this.secret);

  final Secret secret;
  Unserializer unserializer = Unserializer();
  UserData user_data =
      UserData("", "https://i.redd.it/9n242vp9u7r31.png", "", 0);
  String json_user_data = "";
  APIRequest api_request = APIRequest();
  bool refresh = true;

  Widget build(BuildContext context) {
    if (refresh) {
      refresh = false;
      api_request.RequestUserData(this.secret).then((String result) {
        setState(() {
          json_user_data = result;
        });
      });
    }
    if (json_user_data != "")
      user_data = unserializer.getUserDatafromJson(json_user_data);

    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(
                    user_data.icon_img,
                    scale: 3,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        user_data.name,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ))
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Image.network(
                      "https://emoji.redditmedia.com/01qkrmh70ho41_t5_2qhhz/orange",
                      scale: 4,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          user_data.total_karma.toString() + " Karma",
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Your desciption: \n\n" + user_data.description,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
