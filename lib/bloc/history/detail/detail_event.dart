import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DetailEvent extends Equatable {}

class FetchDataEvent extends DetailEvent {
  final String transId;

  FetchDataEvent({@required this.transId});

  @override
  List<Object> get props => [transId];
}

class IsErrorEvent extends DetailEvent {
  final String message;

  IsErrorEvent({@required this.message});

  @override
  List<Object> get props => [message];
}
