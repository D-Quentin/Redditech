import "dart:convert";

class UserData {
  UserData(this.name, this.icon_img, this.description, this.total_karma);

  final String name;
  final String icon_img;
  final String description;
  final int total_karma;
}

class SubscribedSubreddit {
  SubscribedSubreddit(this.display_name);

  final String display_name;
}

class Post {
  Post(this.after, this.title, this.author, this.subreddit, this.ups,
      this.downs, this.imageUrl, this.selftext, this.numComment, this.name) {
    if (imageUrl.contains("www.reddit.com")) {
      this.imageUrl = "";
    }
    if (selftext.contains("https://preview.redd.it/")) {
      this.link = selftext;
      this.selftext = "";
    }
  }

  int ups;
  int downs;
  String link = "";
  String imageUrl;
  String selftext;
  final String name;
  final String after;
  final String title;
  final String author;
  final int numComment;
  final String subreddit;
}

class UserSettings {
  UserSettings(
      this.over_18,
      this.enable_followers,
      this.no_profanity,
      this.show_location_based_recommendations,
      this.third_party_personalized_ads,
      this.email_private_message);

  bool over_18;
  bool enable_followers;
  bool no_profanity;
  bool show_location_based_recommendations;
  bool third_party_personalized_ads;
  bool email_private_message;
}

class Unserializer {
  Map getJsonDecode(String str) {
    Map j = {};

    try {
      return jsonDecode(str);
    } on FormatException {
      return j;
    }
  }

  getUserDatafromJson(String str) {
    Map j = getJsonDecode(str);
    if (j.isEmpty) return [];
    return UserData(
        j["name"] as String,
        (j["icon_img"] as String).replaceAll("amp;", ""),
        j["subreddit"]["public_description"] as String,
        j["total_karma"] as int);
  }

  UserSettings getUserSettingsfromJson(String str) {
    Map j = jsonDecode(str);
    return UserSettings(
      j["over_18"] as bool,
      j["enable_followers"] as bool,
      j["no_profanity"] as bool,
      j["show_location_based_recommendations"] as bool,
      j["third_party_personalized_ads"] as bool,
      j["email_private_message"] as bool,
    );
  }

  List<SubscribedSubreddit> getSubcribbedSubredditFromJson(String str) {
    Map j = getJsonDecode(str);
    if (j.isEmpty) return [];
    int nb = int.parse(j["data"]["dist"].toString());
    List<SubscribedSubreddit> allSub = [];
    for (int i = 1; i < nb; i += 1) {
      allSub.add(SubscribedSubreddit(
        j["data"]["children"][i]["data"]["display_name_prefixed"] as String,
      ));
    }
    return allSub;
  }

  List<Post> getPostFromJson(String str) {
    Map j = getJsonDecode(str);
    if (j.isEmpty) return [];
    List<Post> posts = [];
    int nb = j["data"]["dist"];
    for (int i = 0; i < nb; i += 1) {
      posts.add(Post(
        j["data"]["after"] as String,
        j["data"]["children"][i]["data"]["title"] as String,
        j["data"]["children"][i]["data"]["author"] as String,
        j["data"]["children"][i]["data"]["subreddit_name_prefixed"] as String,
        j["data"]["children"][i]["data"]["ups"] as int,
        j["data"]["children"][i]["data"]["downs"] as int,
        j["data"]["children"][i]["data"]["url"] as String,
        j["data"]["children"][i]["data"]["selftext"] as String,
        j["data"]["children"][i]["data"]["num_comments"] as int,
        j["data"]["children"][i]["data"]["name"] as String,
      ));
    }
    return posts;
  }
}
