import 'package:clone_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUsers) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUsers)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retValue = [];
      for (var element in query.docs) {
        retValue.add(User.fromSnap(element));
      }
      return retValue;
    }));
  }
}
