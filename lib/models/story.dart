import 'package:cloud_firestore/cloud_firestore.dart';


///I'm adding only image you can add video as well
///for [image] and [video] both
///you need to only add a [mediaType] variable,
///then pass the particular [type] and at the time of retrieval
///just compare the type and display according to it.
///It's your task
///
/// Hint:
///
/// enum MediaType{
/// image,
/// video
/// }
///
/// [MediaType.image] for image
/// [MediaType.video] for video
///
///
class Story {
  List<String>? url; // storyUrls ,, change it
  String? userName;
  String? userUrl;
  /// Here MediaType mediaType;

  Story(
    this.url,
    this.userName,
    this.userUrl
  );

  Story.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    url = documentSnapshot['storyUrl'].cast<String>();
    userName = documentSnapshot['userName'];
    userUrl = documentSnapshot['userUrl'];
  }
}