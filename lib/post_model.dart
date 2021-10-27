import "dart:convert";
import "dart:developer";
import "package:http/http.dart";

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

class UserData {
  UserData(this.name, this.icon_img, this.description, this.total_karma,
      this.over_18);

  final String name;
  final String icon_img;
  final String description;
  final int total_karma;
  final bool over_18;
}

class SubscribedSubreddit {
  SubscribedSubreddit(this.display_name);

  final String display_name;
}

class Post {
  Post(this.after, this.title, this.author, this.subreddit, this.ups,
      this.downs);

  final int ups;
  final int downs;
  final String after;
  final String title;
  final String author;
  final String subreddit;
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
        j["icon_img"] as String,
        j["subreddit"]["public_description"] as String,
        j["total_karma"] as int,
        j["over_18"] as bool);
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
    print(str);
    Map j = getJsonDecode(str);
    if (j.isEmpty) return [];
    List<Post> posts = [];
    int nb = j["data"]["dist"];
    for (int i = 1; i < nb; i += 1) {
      posts.add(Post(
        j["data"]["after"] as String,
        j["data"]["children"][i]["data"]["title"] as String,
        j["data"]["children"][i]["data"]["author_fullname"] as String,
        j["data"]["children"][i]["data"]["subreddit_name_prefixed"] as String,
        j["data"]["children"][i]["data"]["ups"] as int,
        j["data"]["children"][i]["data"]["downs"] as int,
      ));
    }
    return posts;
  }
}
