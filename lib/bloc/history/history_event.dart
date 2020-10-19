import 'package:bookstorebloc/model/history_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HistoryEvent extends Equatable {}

class IsFetchDataEvent extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class OnScrollPage extends HistoryEvent{
  final int page;
  final List<HistoryModel> data;
  OnScrollPage({@required this.page, @required this.data});

  @override
  List<Object> get props => [page, data];
}

class IsErrorEvent extends HistoryEvent {
  final String message;
  IsErrorEvent({@required this.message});

  @override
  List<Object> get props => [message];
}
