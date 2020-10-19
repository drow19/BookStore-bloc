import 'dart:convert';
import 'package:bookstorebloc/bloc/transaction/transaction_event.dart';
import 'package:bookstorebloc/bloc/transaction/transaction_state.dart';
import 'package:bookstorebloc/data/transaction_repository.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionRepository transactionRepository;

  TransactionBloc({@required this.transactionRepository});

  @override
  TransactionState get initialState => InitialTransState();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is PostTransaction) {
      yield TransactionIsLoading();
      try {
        await Future.delayed(new Duration(seconds: 3));

        //get user id from sharedpreferences
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        var userId = sharedPreferences.getInt('id');

        BookModel bookModel;
        List<Map<String, dynamic>> book = new List();
        Map<String, dynamic> toJson() =>{
          'id':bookModel.id
        };


        for (int i = 0; i < event.book.length; i++) {
          bookModel = event.book[i];
          Map<String, dynamic> json;
          json = toJson();
          book.add(json);
        }

        //create jsonobject to post
        var object = jsonEncode({'user_id': userId, 'books': book});

        print("print : $object");

        var data = await transactionRepository.postData(object);
        var json = jsonDecode(data);
        yield TransactionIsSuccess(message: json['success']);
      } catch (e) {
        print(e.toString());
        yield TransactionIsError(message: e.toString());
      }
    }
  }
}
