import 'dart:convert';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:http/http.dart' as http;

class TransactionRepository {
  Future<String> postData(var data) async {
    String _url = '$base_url/transaction';

    var response = await http.post(Uri.encodeFull(_url),
        body: data, headers: {'Content-type': 'application/json'});
    print('$_url ${response.body}');

    if (response.statusCode == 200) {
      print("print response: ${jsonDecode(response.body)}");
      return response.body;
    } else {
      print("error");
      throw Exception();
    }
  }
}
