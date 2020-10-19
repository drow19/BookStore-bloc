import 'package:bookstorebloc/bloc/auth/auth_bloc.dart';
import 'package:bookstorebloc/bloc/auth/auth_event.dart';
import 'package:bookstorebloc/bloc/auth/auth_state.dart';
import 'package:bookstorebloc/view/home/home_screen.dart';
import 'package:bookstorebloc/view/login/login_screen.dart';
import 'package:bookstorebloc/widget/bezier_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AuthBloc _bloc;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthBloc>(context);
    AddLoadingDelay(context);
    super.initState();
  }

  AddLoadingDelay(BuildContext context){
    Future.delayed(const Duration(seconds:  3)).then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            Future.delayed(Duration(seconds: 3), (){
              /*Navigator.of(context).pop(true);*/
              _bloc.add(CheckUserLogin());
            });
            return CupertinoAlertDialog(
              title: Text("Loading..."),
              content: CupertinoActivityIndicator(radius: 15,),
            );
          }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener(
      bloc: _bloc,
      listener: (context, state){
        if (state is UserLoginState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * .4,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            top: -height * .15,
                            right: -MediaQuery.of(context).size.width * .4,
                            child: BezierContainer()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  Flexible(child: _title()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'B',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: Color(0xff00897B),
          ),
          children: [
            TextSpan(
              text: 'ook',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),
            TextSpan(
              text: 'App',
              style: TextStyle(color: Color(0xff039BE5), fontSize: 50),
            ),
          ]),
    );
  }
}
