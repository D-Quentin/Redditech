import 'dart:math';

class Secret {
  int expire = 0;
  String code = "";
  String token = "";
  String refresh = "";
  final String clientId = "jxBxVNUvSl3V-lWkoLLirQ";
  final String redirectUri = "http://localhost:8080/";
  final String secret = "aAwmlCujxVvMlMEaj1fSxDJCqCzwig";
  String randomString = "failed_to_create_random_string";

  Secret() {
    var r = Random();
    const _chars =
        "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
    this.randomString =
        List.generate(32, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  String getRandomString() {
    return this.randomString;
  }

  String getClientID() {
    return this.clientId;
  }

  String getRedirectUri() {
    return this.redirectUri;
  }

  void setCode(String code) {
    this.code = code;
  }

  String getCode() {
    return this.code;
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

  String getSecret() {
    return this.secret;
  }

  void setRefresh(String string) {
    this.refresh = string;
  }

  String getRefresh() {
    return this.refresh;
  }
}
