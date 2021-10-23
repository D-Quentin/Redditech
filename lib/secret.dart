import 'dart:math';

class Secret {
  int expire = 0;
  String token = "";
  final String client_id = "vDOZMIKkPssp-b7aQwApUw";
  final String redirect_uri = "http://localhost:8080/";
  String random_string = "failed_to_create_random_string";

  Secret() {
    var r = Random();
    const _chars =
        "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
    this.random_string =
        List.generate(32, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  String getRandomString() {
    return this.random_string;
  }

  String getClientID() {
    return this.client_id;
  }

  String getRedirectUri() {
    return this.redirect_uri;
  }

  void setToken(String token) {
    this.token = token;
  }

  String getToken() {
    return this.token;
  }

  void setExpire(int expire) {
    this.expire = expire;
  }

  int getExpire() {
    return this.expire;
  }
}
