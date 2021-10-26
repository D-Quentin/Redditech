import "package:flutter/material.dart";
import "package:redditech/secret.dart";
import "package:flutter/material.dart";
import "package:redditech/post_model.dart";
import 'package:redditech/api_request.dart';

class SubredditNewWidget extends StatefulWidget {
  SubredditNewWidget(this.secret);

  final Secret secret;

  @override
  SubredditNewWidgetState createState() => SubredditNewWidgetState(secret);
}

class SubredditNewWidgetState extends State<SubredditNewWidget> {
  SubredditNewWidgetState(this.secret);

  bool refresh = true;
  final Secret secret;
  String json_content = "";
  Unserializer unserializer = Unserializer();
  APIRequest api_request = APIRequest();

  Widget build(BuildContext build) {
    if (refresh) {
      refresh = false;
      api_request.RequestSubscribedSubreddit(this.secret).then((String string) {
        List<SubscribedSubreddit> subreddit_list =
            unserializer.getSubcribbedSubredditFromJson(string);
        List<Post> post_list = [];
        for (var it = subreddit_list.iterator; it.moveNext();) {
          api_request.RequestNewPost(this.secret, it.current.display_name)
              .then((String string) {
            post_list.add(unserializer.getPostFromJson(string));
          });
        }
      });

      //     json_content = result;
      //   });
      // });
    }
    return Center(child: Text("Salut"));
    // if (json_content != "")
  }
}
