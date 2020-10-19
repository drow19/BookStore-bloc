import 'dart:convert';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/user_model.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  Future<UserModel> getData(String email, String password) async {
    String _url = base_url + '/login';

    var response =
        await http.post(_url, body: {'email':email, 'password':password});

    var json = jsonDecode(response.body);
    var data = json['data'];

    if (response.statusCode == 200)
      return UserModel.fromJson(data);
    else
      throw Exception();
  }
}
