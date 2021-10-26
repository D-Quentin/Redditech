import "dart:convert";
import 'dart:developer';

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
  Post(this.title);

  final String title;
}

class Unserializer {
  UserData getUserDatafromJson(String str) {
    Map j = jsonDecode(str);
    return UserData(
        j["name"] as String,
        j["icon_img"] as String,
        j["subreddit"]["public_description"] as String,
        j["total_karma"] as int,
        j["over_18"] as bool);
  }

  List<SubscribedSubreddit> getSubcribbedSubredditFromJson(String str) {
    Map j = jsonDecode(str);
    int nb = (j["data"]["dist"]);
    List<SubscribedSubreddit> all_sub = [];
    for (int i = 1; i < nb; i += 1) {
      all_sub.add(SubscribedSubreddit(
        j["data"]["children"][i]["data"]["display_name_prefixed"] as String,
      ));
    }
    return all_sub;
  }

  Post getPostFromJson(String str) {
    Map j = jsonDecode(str);
    print(str);
    return Post("test");
  }
}
