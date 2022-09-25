import 'dart:io';

import 'package:clone_app/controllers/upload_video_controller.dart';
import 'package:clone_app/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  @override
  void initState() {
    super.initState();

    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.setVolume(1);
    controller.play();
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: VideoPlayer(controller),
          ),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                  },
                  child: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextInputField(
                      controller: _songController,
                      labelText: 'Song name',
                      icon: Icons.music_note),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextInputField(
                      controller: _captionController,
                      labelText: 'Caption',
                      icon: Icons.closed_caption),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => uploadVideoController.uploadVideo(
                        _songController.text,
                        _captionController.text,
                        widget.videoPath),
                    child: Text(
                      'Share!',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
