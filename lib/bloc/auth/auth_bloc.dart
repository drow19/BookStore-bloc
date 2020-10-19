import 'package:bloc/bloc.dart';
import 'package:bookstorebloc/bloc/auth/auth_event.dart';
import 'package:bookstorebloc/bloc/auth/auth_state.dart';
import 'package:bookstorebloc/data/login_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginRepo loginRepo;

  AuthBloc({@required this.loginRepo});

  @override
  AuthState get initialState => InitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoadingState();
      try {
        await Future.delayed(const Duration(seconds: 3));
        var data = await loginRepo.getData(event.email, event.password);
        yield IsLogged(userModel: data);
      } catch (e) {
        print("print Error : $e");
        throw Exception();
      }
    } else if(event is CheckUserLogin){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var userData = sharedPreferences.getInt('id');
      if(userData != null){
        yield UserLoginState();
      }else {
        yield UserLogOutState();
      }
    }else if(event is LogoutEvent){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      yield UserLogOutState();
    }else if (event is ErrorEvent) {
      print("print event: ${event.message}");
    }
  }
}