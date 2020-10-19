import 'package:bookstorebloc/bloc/auth/auth_bloc.dart';
import 'package:bookstorebloc/bloc/auth/auth_state.dart';
import 'package:bookstorebloc/data/login_repository.dart';
import 'package:bookstorebloc/view/home/home_screen.dart';
import 'package:bookstorebloc/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthService extends StatefulWidget {
  @override
  _AuthServiceState createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: AuthBloc(loginRepo: LoginRepo()),
      listener: (context, state) {
        if (state is UserLoginState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      child: Container(),
    );
  }
}
