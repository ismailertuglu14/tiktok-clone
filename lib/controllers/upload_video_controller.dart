import 'dart:io';

import 'package:clone_app/constants.dart';
import 'package:clone_app/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref('Videos').child(id);
    UploadTask uploadTask = ref.putFile(File(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref('Thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      // get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;

      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
          username: (userDoc.data() as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          sharedCount: 0,
          songname: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto:
              (userDoc.data() as Map<String, dynamic>)['profilePhoto']);
      await firestore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());
      Get.back(); // Push toPrevious Page
    } catch (e) {
      Get.snackbar('Error Uploading Video', e.toString());
      debugPrint(e.toString());
    }
  }
}
