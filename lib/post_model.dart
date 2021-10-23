import "dart:convert";

class UserData {
  final String display_name;
  final String icon_img;
  final String description;

  UserData(this.display_name, this.icon_img, this.description);
}

class Unserializer {
  UserData getUserDatafromJson(String str) {
    final j = json.decode(str);
    return UserData(j["userId"] as String, j["icon_img"] as String,
        j["description"] as String);
  }
}
