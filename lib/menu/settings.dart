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
  UserData userData =
      UserData("", "https://i.redd.it/9n242vp9u7r31.png", "", 0);
  UserSettings userSettings =
      UserSettings(false, false, false, false, false, false);
  String jsonUserData = "";
  String jsonUserSettings = "";
  APIRequest apiRequest = APIRequest();
  int refreshUserData = 0;
  int refreshUserSettings = 0;
  int settingsChange = 0;

  Widget build(BuildContext context) {
    if (refreshUserData == 0) {
      refreshUserData = 1;
      apiRequest.requestUserData(this.secret).then((String result) {
        setState(() {
          jsonUserData = result;
          refreshUserData = 2;
        });
      });
    }
    if (refreshUserSettings == 0) {
      refreshUserSettings = 1;
      apiRequest.requestUserSettings(this.secret).then((String result) {
        setState(() {
          jsonUserSettings = result;
          refreshUserSettings = 2;
        });
      });
    }
    if (jsonUserData != "" && refreshUserData == 2) {
      refreshUserData = 3;
      userData = unserializer.getUserDatafromJson(jsonUserData);
    }
    if (jsonUserSettings != "" && refreshUserSettings == 2) {
      refreshUserSettings = 3;
      userSettings = unserializer.getUserSettingsfromJson(jsonUserSettings);
    }
    switch (settingsChange) {
      case 1:
        if (userSettings.over_18)
          apiRequest.updateUserSettings(secret, '{"over_18": true}');
        else
          apiRequest.updateUserSettings(secret, '{"over_18": false}');
        settingsChange = 0;
        break;
      case 2:
        if (userSettings.enable_followers)
          apiRequest.updateUserSettings(secret, '{"enable_followers": true}');
        else
          apiRequest.updateUserSettings(secret, '{"enable_followers": false}');
        settingsChange = 0;
        break;
      case 3:
        if (userSettings.no_profanity)
          apiRequest.updateUserSettings(secret, '{"no_profanity": true}');
        else
          apiRequest.updateUserSettings(secret, '{"no_profanity": false}');
        settingsChange = 0;
        break;
      case 4:
        if (userSettings.show_location_based_recommendations)
          apiRequest.updateUserSettings(
              secret, '{"show_location_based_recommendations": true}');
        else
          apiRequest.updateUserSettings(
              secret, '{"show_location_based_recommendations": false}');
        settingsChange = 0;
        break;
      case 5:
        if (userSettings.third_party_personalized_ads)
          apiRequest.updateUserSettings(
              secret, '{"third_party_personalized_ads": true}');
        else
          apiRequest.updateUserSettings(
              secret, '{"third_party_personalized_ads": false}');
        settingsChange = 0;
        break;
      case 6:
        if (userSettings.email_private_message)
          apiRequest.updateUserSettings(
              secret, '{"email_private_message": true}');
        else
          apiRequest.updateUserSettings(
              secret, '{"email_private_message": false}');
        settingsChange = 0;
        break;
      default:
        break;
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      userData.icon_img,
                      scale: 3,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          userData.name,
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
                            userData.total_karma.toString() + " Karma",
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
                    padding: const EdgeInsets.only(top: 20, bottom: 12),
                    child: Text(
                      "Your desciption: \n\n" + userData.description,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Settings: \n",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Adult content",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                          value: userSettings.over_18,
                          onChanged: (value) {
                            setState(() {
                              userSettings.over_18 = value;
                              settingsChange = 1;
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enable followers",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                          value: userSettings.enable_followers,
                          onChanged: (value) {
                            setState(() {
                              userSettings.enable_followers = value;
                              settingsChange = 2;
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "No profanity",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                          value: userSettings.no_profanity,
                          onChanged: (value) {
                            setState(() {
                              userSettings.no_profanity = value;
                              settingsChange = 3;
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Show location based recommendations",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                          value:
                              userSettings.show_location_based_recommendations,
                          onChanged: (value) {
                            setState(() {
                              userSettings.show_location_based_recommendations =
                                  value;
                              settingsChange = 4;
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Third party personalized ads",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                          value: userSettings.third_party_personalized_ads,
                          onChanged: (value) {
                            setState(() {
                              userSettings.third_party_personalized_ads = value;
                              settingsChange = 5;
                            });
                          }),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email private message",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                          value: userSettings.email_private_message,
                          onChanged: (value) {
                            setState(() {
                              userSettings.email_private_message = value;
                              settingsChange = 6;
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
