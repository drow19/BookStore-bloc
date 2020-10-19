import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TransactionState extends Equatable {}

class InitialTransState extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionIsLoading extends TransactionState {
  @override
  List<Object> get props => null;
}

class TransactionIsSuccess extends TransactionState {
  final String message;

  TransactionIsSuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class TransactionIsError extends TransactionState {
  final String message;

  TransactionIsError({@required this.message});

  @override
  List<Object> get props => [message];
}
