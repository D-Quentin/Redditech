import "dart:convert";
import 'dart:developer';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

class UserData {
  final String name;
  final String icon_img;
  final String description;
  final int total_karma;

  UserData(this.name, this.icon_img, this.description, this.total_karma);
}

class Unserializer {
  UserData getUserDatafromJson(String str) {
    Map j = jsonDecode(str);
    return UserData(
        j['name'] as String,
        j["icon_img"] as String,
        j['subreddit']["public_description"] as String,
        j['total_karma'] as int);
  }
}
