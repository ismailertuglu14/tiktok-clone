import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int sharedCount;
  String songname;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.sharedCount,
    required this.songname,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "sharedCount": sharedCount,
        "songName": songname,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
        "profilePhoto": profilePhoto
      };
  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot['username'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      sharedCount: snapshot['sharedCount'],
      songname: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      thumbnail: snapshot['thumbnail'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
