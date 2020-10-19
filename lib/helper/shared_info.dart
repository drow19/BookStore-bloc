import 'package:bookstorebloc/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedInfo{
  SharedPreferences sharedPreferences;

  //save info logged in to shared preferences
  void sharedLoginSave(UserModel userModel) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("id", userModel.id);
    sharedPreferences.setString("username", userModel.username);
  }
}