import 'package:bookstorebloc/model/history_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HistoryState extends Equatable {}

class IsloadingState extends HistoryState {
  @override
  List<Object> get props => [];
}

class IsLoadedState extends HistoryState {
  final List<HistoryModel> list;

  IsLoadedState({@required this.list});

  @override
  List<Object> get props => [list];
}

class IsErrorState extends HistoryState {
  final String message;

  IsErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
