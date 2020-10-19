import 'package:bookstorebloc/bloc/home/home_event.dart';
import 'package:bookstorebloc/bloc/home/home_state.dart';
import 'package:bookstorebloc/data/home_repository.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository;

  HomeBloc({@required this.repository});

  @override
  HomeState get initialState => IsLoadingHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is IsFetchData) {
      try {
        await Future.delayed(const Duration(seconds: 2));
        List<BookModel> data = await repository.getData(1);
        yield FetchData(list: data);
      } catch (e) {
        yield IsErrorHomeState(message: e.toString());
      }
    } else if (event is OnScrollPage) {
      try {
        List<BookModel> prev = event.data;
        List<BookModel> data = await repository.getData(event.page);
        prev = [...prev, ...data];
        yield FetchData(list: prev);
      } catch (e) {
        yield IsErrorHomeState(message: e.toString());
      }
    }
  }
}
