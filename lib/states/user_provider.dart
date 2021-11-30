import 'package:blueberry/constants/shared_pref_keys.dart';
import 'package:blueberry/data/user_model.dart';
import 'package:blueberry/repo/user_service.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    initUser();
  }

  User? _user;
  UserModel? _userModel;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _setNewUser(user);
      // _user = user;
      notifyListeners();
    });
  }

  Future _setNewUser(User? user) async {
    _user = user;
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String address = prefs.getString(SHARED_ADDRESS) ?? "";
      double lat = prefs.getDouble(SHARED_LAT) ?? 0;
      double lon = prefs.getDouble(SHARED_LON) ?? 0;
      String phoneNumber = user.phoneNumber.toString();
      String userKey = user.uid;

      // final geo = Geoflutterfire();
      // GeoFirePoint myLocation = geo.point(latitude: lat, longitude: lon);

      UserModel userModel = UserModel(
          geoFirePoint: GeoFirePoint(lat, lon),
          userKey: userKey,
          phoneNumber: phoneNumber,
          address: address,
          createdDate: DateTime.now().toUtc());

      await UserService().createNewUser(userModel.toJson(), userKey);

      _userModel = await UserService().getUserModel(userKey);
      logger.d(_userModel!.toJson().toString());
    }
  }

  User? get user => _user;
}
