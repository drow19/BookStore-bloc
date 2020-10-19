import 'package:bookstorebloc/model/history_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DetailState extends Equatable {}

class IsLoadingState extends DetailState {
  @override
  List<Object> get props => [];
}

class IsLoadedState extends DetailState {
  final List<DetailTransactionModel> list;

  IsLoadedState({@required this.list});

  @override
  List<Object> get props => [list];
}

class IsErrorState extends DetailState {
  final String message;

  IsErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
