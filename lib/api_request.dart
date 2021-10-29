import "dart:convert";
import "menu/feed_page.dart";
import "package:redditech/secret.dart";
import "package:redditech/http_service.dart";

class APIRequest {
  final HttpService httpService = HttpService();
  final String urlBase = "https://oauth.reddit.com";

  Map<FeedPage, String> feedPageUrl = {
    FeedPage.new_: "/new",
    FeedPage.top_: "/top",
    FeedPage.hot_: "/hot",
  };

  getRequest(String url, Secret secret) {
    Future<dynamic> response =
        httpService.getRequest(urlBase + url, secret.getToken());
    return response;
  }

  getRequestWithHeader(String url, Secret secret, Map<String, String> json) {
    Future<dynamic> response =
        httpService.getRequestHeader(urlBase + url, secret.getToken(), json);
    return response;
  }

  postRequest(
      String url, Map<String, String> header, Map<String, String> body) {
    Future<dynamic> response = httpService.postRequest(url, header, body);
    return response;
  }

  patchRequestWithHeader(String url, Secret secret, json) {
    Future<dynamic> response =
        httpService.patchRequest(urlBase + url, secret.getToken(), json);
    return response;
  }

  requestNewPage(Secret secret) {
    return getRequest("/subreddits/mine/subscriber/", secret);
  }

  requestUserData(Secret secret) {
    // printWrapped(getRequest("api/v1/me", secret));
    return getRequest("api/v1/me", secret);
  }

  requestSubscribedSubreddit(Secret secret) {
    return getRequest("/subreddits/mine/subscriber/", secret);
  }

  requestPost(Secret secret, FeedPage feedpage) {
    String? url = feedPageUrl[feedpage];
    if (url != null) {
      return getRequest(url, secret);
    }
    return "";
  }

  requestPostAfter(Secret secret, FeedPage feedpage, String params) {
    String? url = feedPageUrl[feedpage];
    if (url != null) {
      return getRequest(url + params, secret);
    }
    return "";
  }

  requestToken(Secret secret) {
    final String id = secret.getClientID();
    final String secret_ = secret.getSecret();

    return postRequest("https://ssl.reddit.com/api/v1/access_token", {
      "Authorization": "Basic " + base64.encode(utf8.encode("$id:$secret_"))
    }, {
      "grant_type": "authorization_code",
      "code": secret.getCode(),
      "redirect_uri": secret.getRedirectUri()
    });
  }

  requestUserSettings(Secret secret) {
    return getRequest("/api/v1/me/prefs", secret);
  }

  updateUserSettings(Secret secret, String settings) {
    return patchRequestWithHeader("/api/v1/me/prefs", secret, settings);
  }

  VotePost(Secret secret, String postname, int vote) {
    print(secret.getToken());
    print(vote.toString());
    print(postname);
    postRequest("https://oauth.reddit.com/api/vote/", {
      "Authorization": "bearer ${secret.getToken()}",
    }, {
      "dir": vote.toString(),
      "id": postname,
      "rank": "10",
    });
  }
}
