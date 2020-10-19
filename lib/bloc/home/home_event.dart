import 'package:bookstorebloc/model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable{

}

class IsLoadingHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];

}

class IsFetchData extends HomeEvent{

  final List<BookModel> list;
  IsFetchData({@required this.list});

  @override
  List<Object> get props => [list];

}

class OnScrollPage extends HomeEvent{
  final int page;
  final List<BookModel> data;
  OnScrollPage({@required this.page, this.data});

  @override
  List<Object> get props => [page];

}

class IsErrorHomeEvent extends HomeEvent {

  final String message;
  IsErrorHomeEvent({@required this.message});

  @override
  List<Object> get props => [message];

}