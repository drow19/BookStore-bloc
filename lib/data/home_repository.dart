import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/book_model.dart';

class HomeRepository{
  Future<List<BookModel>> getData(int page) async {
    String _url = base_url + '/book?page=$page';

    final response = await http.get(_url);

    if (response.statusCode == 200)
      return jsonParse(response.body);
    else
      throw Exception();
  }

  List<BookModel> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['data'];

    return new List<BookModel>.from(
        data.map((value) => BookModel.fromJson(value)));
  }
}