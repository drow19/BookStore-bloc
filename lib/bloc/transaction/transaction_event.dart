import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TransactionEvent extends Equatable {}

class PostTransaction extends TransactionEvent {
  final book;

  PostTransaction({@required this.book});

  @override
  List<Object> get props => [book];
}
