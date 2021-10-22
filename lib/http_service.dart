import "dart:convert";
import "package:http/http.dart";
import "package:redditech/post_model.dart";

class HttpService {
  HttpService(this.postUrl);
  String postUrl;

  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(postUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Post> posts = body.map((dynamic itm) => Post.fromJson(itm)).toList();
      print(posts[1]);
      print(posts[2]);
      print(posts[3]);
      print(posts[4]);
      print(posts[5]);
      print(posts[6]);
      print(posts[7]);
      return posts;
    } else
      throw "HttpService failed: unable to retrieve post";
  }
}
