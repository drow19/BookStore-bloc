import 'dart:convert';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/history_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {
  Future<List<HistoryModel>> getData(int page) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.get('id');

    String _url = '$base_url/transaction_list/$userId?page=$page';

    var response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<HistoryModel> jsonParse(var response) {
    var json = jsonDecode(response);
    var data = json['data'];

    return new List<HistoryModel>.from(
        data.map((value) => HistoryModel.fromJson(value)));
  }
}
