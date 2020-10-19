import 'package:bookstorebloc/model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CartEvent extends Equatable {}

class AddToCart extends CartEvent {
  final BookModel bookModel;

  AddToCart({@required this.bookModel});

  @override
  List<Object> get props => [bookModel];
}

class RemoveFromCart extends CartEvent {
  final int index;

  RemoveFromCart({@required this.index});

  @override
  List<Object> get props => [index];
}

class ClearCart extends CartEvent {
  @override
  List<Object> get props => [];
}
