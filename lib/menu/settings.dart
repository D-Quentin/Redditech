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
      UserData("", "https://i.redd.it/9n242vp9u7r31.png", "", 0);
  UserSettings user_settings =
      UserSettings(false, false, false, false, false, false);
  String json_user_data = "";
  String json_user_settings = "";
  APIRequest api_request = APIRequest();
  int refresh_user_data = 0;
  int refresh_user_settings = 0;
  int settings_change = 0;

  Widget build(BuildContext context) {
    if (refresh_user_data == 0) {
      refresh_user_data = 1;
      // api_request.RequestUserData(this.secret).then((String result) {
      //   setState(() {
      //     json_user_data = result;
      //     refresh_user_data = 2;
      //   });
      // });
    }
    if (refresh_user_settings == 0) {
      refresh_user_settings = 1;
      // api_request.RequestUserSettings(this.secret).then((String result) {
      //   setState(() {
      //     json_user_settings = result;
      //     refresh_user_settings = 2;
      //   });
      // });
    }
    if (json_user_data != "" && refresh_user_data == 2) {
      refresh_user_data = 3;
      user_data = unserializer.getUserDatafromJson(json_user_data);
    }
    if (json_user_settings != "" && refresh_user_settings == 2) {
      refresh_user_settings = 3;
      user_settings = unserializer.getUserSettingsfromJson(json_user_settings);
    }
    switch (settings_change) {
      case 1:
        if (user_settings.over_18)
          api_request.UpdateUserSettings(secret, '{"over_18": true}');
        else
          api_request.UpdateUserSettings(secret, '{"over_18": false}');
        settings_change = 0;
        break;
      case 2:
        if (user_settings.enable_followers)
          api_request.UpdateUserSettings(secret, '{"enable_followers": true}');
        else
          api_request.UpdateUserSettings(secret, '{"enable_followers": false}');
        settings_change = 0;
        break;
      case 3:
        if (user_settings.no_profanity)
          api_request.UpdateUserSettings(secret, '{"no_profanity": true}');
        else
          api_request.UpdateUserSettings(secret, '{"no_profanity": false}');
        settings_change = 0;
        break;
      case 4:
        if (user_settings.show_location_based_recommendations)
          api_request.UpdateUserSettings(
              secret, '{"show_location_based_recommendations": true}');
        else
          api_request.UpdateUserSettings(
              secret, '{"show_location_based_recommendations": false}');
        settings_change = 0;
        break;
      case 5:
        if (user_settings.third_party_personalized_ads)
          api_request.UpdateUserSettings(
              secret, '{"third_party_personalized_ads": true}');
        else
          api_request.UpdateUserSettings(
              secret, '{"third_party_personalized_ads": false}');
        settings_change = 0;
        break;
      case 6:
        if (user_settings.email_private_message)
          api_request.UpdateUserSettings(
              secret, '{"email_private_message": true}');
        else
          api_request.UpdateUserSettings(
              secret, '{"email_private_message": false}');
        settings_change = 0;
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
                    padding: const EdgeInsets.only(top: 20, bottom: 12),
                    child: Text(
                      "Your desciption: \n\n" + user_data.description,
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
                          value: user_settings.over_18,
                          onChanged: (value) {
                            setState(() {
                              user_settings.over_18 = value;
                              settings_change = 1;
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
                          value: user_settings.enable_followers,
                          onChanged: (value) {
                            setState(() {
                              user_settings.enable_followers = value;
                              settings_change = 1;
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
                          value: user_settings.no_profanity,
                          onChanged: (value) {
                            setState(() {
                              user_settings.no_profanity = value;
                              settings_change = 1;
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
                              user_settings.show_location_based_recommendations,
                          onChanged: (value) {
                            setState(() {
                              user_settings
                                  .show_location_based_recommendations = value;
                              settings_change = 1;
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
                          value: user_settings.third_party_personalized_ads,
                          onChanged: (value) {
                            setState(() {
                              user_settings.third_party_personalized_ads =
                                  value;
                              settings_change = 1;
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
                          value: user_settings.email_private_message,
                          onChanged: (value) {
                            setState(() {
                              user_settings.email_private_message = value;
                              settings_change = 1;
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
