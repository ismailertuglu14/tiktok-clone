import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_app/constants.dart';
import 'package:clone_app/controllers/profile_controler.dart';
import 'package:clone_app/views/screens/directed_video_screen.dart';
import 'package:clone_app/views/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileControler profileControler = Get.put(ProfileControler());
  @override
  void initState() {
    super.initState();
    profileControler.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileControler>(
        init: ProfileControler(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: const Icon(Icons.person_add_alt_1_outlined),
                actions: const [Icon(Icons.more_horiz)],
                title: Text(
                  controller.user['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: controller.user['profilePhoto'],
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    controller.user['following'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Following',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.black,
                                width: 1,
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              ),
                              Column(
                                children: [
                                  Text(
                                    controller.user['followers'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Followers',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.black,
                                width: 1,
                                height: 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              ),
                              Column(
                                children: [
                                  Text(
                                    controller.user['likes'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Likes',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: 140,
                            height: 47,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if (widget.uid == authController.user.uid) {
                                    authController.signOut();
                                  } else {
                                    controller.followUser();
                                  }
                                },
                                child: Text(
                                  widget.uid == authController.user.uid
                                      ? 'Sign Out'
                                      : controller.user['isFollowing']
                                          ? 'Unfollow'
                                          : 'Follow',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Video List
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.user['thumbnails'].length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 5),
                              itemBuilder: (context, index) {
                                String thumbnail =
                                    controller.user['thumbnails'][index];
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DirectedVideoScreen(
                                                  data: 'Deneme'))),
                                  child: CachedNetworkImage(
                                    imageUrl: thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
