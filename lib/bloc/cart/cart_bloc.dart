import 'package:bookstorebloc/bloc/cart/cart_event.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CartBloc extends Bloc<CartEvent, List<BookModel>>{
  List<BookModel> list;
  CartBloc({@required this.list});

  @override
  List<BookModel> get initialState => [];

  @override
  Stream<List<BookModel>> mapEventToState(CartEvent event) async* {
    if(event is AddToCart){
      List<BookModel> data = List.from(state, growable: true);
      data.add(event.bookModel);
      yield data;
    }else if(event is RemoveFromCart){
      List<BookModel> data = List.from(state, growable: true);
      data.removeAt(event.index);
      yield data;
    }else if(event is ClearCart){
      List<BookModel> data = List.from(state, growable: true);
      data.clear();
      yield data;
    }
  }

}