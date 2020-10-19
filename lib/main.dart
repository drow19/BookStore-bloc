import 'package:bookstorebloc/bloc/auth/auth_bloc.dart';
import 'package:bookstorebloc/bloc/cart/cart_bloc.dart';
import 'package:bookstorebloc/bloc/history/bloc.dart';
import 'package:bookstorebloc/bloc/history/detail/bloc.dart';
import 'package:bookstorebloc/bloc/home/home_bloc.dart';
import 'package:bookstorebloc/bloc/transaction/bloc.dart';
import 'package:bookstorebloc/data/detail_trans_repository.dart';
import 'package:bookstorebloc/data/history_repository.dart';
import 'package:bookstorebloc/data/home_repository.dart';
import 'package:bookstorebloc/data/login_repository.dart';
import 'package:bookstorebloc/data/transaction_repository.dart';
import 'package:bookstorebloc/view/login/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(loginRepo: LoginRepo())),
        BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(repository: HomeRepository())),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider<TransactionBloc>(
            create: (context) => TransactionBloc(
                transactionRepository: TransactionRepository())),
        BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc(repository: HistoryRepository())),
        BlocProvider<DetailBloc>(
            create: (context) =>
                DetailBloc(repository: DetailTransRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
