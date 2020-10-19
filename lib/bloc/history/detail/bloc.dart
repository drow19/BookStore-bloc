import 'package:bookstorebloc/bloc/history/detail/detail_event.dart';
import 'package:bookstorebloc/bloc/history/detail/detail_state.dart';
import 'package:bookstorebloc/data/detail_trans_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailTransRepository repository;

  DetailBloc({@required this.repository});

  @override
  DetailState get initialState => IsLoadingState();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is FetchDataEvent) {
      yield IsLoadingState();
      try {
        Future.delayed(const Duration(seconds: 3));
        final data = await repository.getData(event.transId);
        yield IsLoadedState(list: data);
      } catch (e) {
        yield IsErrorState(message: e.toString());
      }
    }
  }
}
