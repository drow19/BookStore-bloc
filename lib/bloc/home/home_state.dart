import 'package:bookstorebloc/model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable {}

class IsLoadingHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class FetchData extends HomeState {
  final List<BookModel> list;

  FetchData({@required this.list});

  @override
  List<Object> get props => [list];
}

class IsErrorHomeState extends HomeState {
  final String message;

  IsErrorHomeState({@required this.message});

  @override
  List<Object> get props => [message];
}
