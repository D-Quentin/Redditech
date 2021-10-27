import "package:redditech/secret.dart";
import "package:flutter/material.dart";
import "package:redditech/post_model.dart";
import "package:redditech/api_request.dart";

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
      UserData("", "https://i.redd.it/9n242vp9u7r31.png", "", 0, false);
  String json_user_data = "";
  APIRequest api_request = APIRequest();
  int refresh = 0;
  bool statut_over_18 = false;
  int settings_change = 0;

  Widget build(BuildContext context) {
    if (refresh == 0) {
      refresh = 1;
      api_request.requestUserData(this.secret).then((String result) {
        setState(() {
          json_user_data = result;
          refresh = 2;
        });
      });
    }
    if (json_user_data != "" && refresh == 2) {
      refresh = 3;
      user_data = unserializer.getUserDatafromJson(json_user_data);
    }

    return Scaffold(
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
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Your desciption: \n\n" + user_data.description,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    "NSFW  ",
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Switch(
                      value: statut_over_18,
                      onChanged: (value) {
                        setState(() {
                          statut_over_18 = value;
                          settings_change = 1;
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
