import 'dart:convert';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/history_model.dart';
import 'package:http/http.dart' as http;

class DetailTransRepository {
  Future<List<DetailTransactionModel>>getData(String transId) async {
    String _url = '$base_url/transaction_detail/$transId';

    var response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<DetailTransactionModel> jsonParse(var response) {
    var json = jsonDecode(response);
    var data = json['data'];

    return new List<DetailTransactionModel>.from(
        data.map((value) => DetailTransactionModel.fromJson(value)));
  }
}
