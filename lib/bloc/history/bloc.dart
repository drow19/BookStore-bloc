import 'package:bookstorebloc/bloc/history/history_event.dart';
import 'package:bookstorebloc/bloc/history/history_state.dart';
import 'package:bookstorebloc/data/history_repository.dart';
import 'package:bookstorebloc/model/history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryRepository repository;

  HistoryBloc({@required this.repository});

  @override
  HistoryState get initialState => IsloadingState();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is IsFetchDataEvent) {
      yield IsloadingState();
      try {
        await Future.delayed(const Duration(seconds: 3));
        List<HistoryModel> list = await repository.getData(1);
        yield IsLoadedState(list: list);
      } catch (e) {
        print("print error : $e");
        yield IsErrorState(message: e.toString());
      }
    }else if(event is OnScrollPage){
      try{
        List<HistoryModel> prev = event.data;
        List<HistoryModel> data = await repository.getData(event.page);
        prev = [...prev, ...data];
        yield IsLoadedState(list: prev);
      }catch(e){
        yield IsErrorState(message: e.toString());
      }
    }
  }
}
