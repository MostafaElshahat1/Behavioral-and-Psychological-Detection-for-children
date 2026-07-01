// core/helper/constance_helper.dart
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

class SharedPrefranceKeys {
  static String userToken = "UserToken";
  static String userRole = "UserRole";
  static String userId = "UserId";
  static String studentId = "StudentId";
}

const String baseUrl = 'http://pixel-vision.runasp.net/api';

bool isLogedInUser = false;
TabController? homeTabController;
TabController? seeAllTabController;
String cartBox = "CartBox";
// late Box cartBoxbox;
String favoritestBox = "favoritestBox";
// late Box favoritestBoxbox;
