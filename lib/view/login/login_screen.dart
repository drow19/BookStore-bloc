import 'package:bookstorebloc/bloc/auth/auth_bloc.dart';
import 'package:bookstorebloc/bloc/auth/auth_event.dart';
import 'package:bookstorebloc/bloc/auth/auth_state.dart';
import 'package:bookstorebloc/helper/shared_info.dart';
import 'package:bookstorebloc/helper/validator.dart';
import 'package:bookstorebloc/view/home/home_screen.dart';
import 'package:bookstorebloc/widget/bezier_container.dart';
import 'package:bookstorebloc/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AuthBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      body: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is IsLogged) {
            /*Navigator.of(context, rootNavigator: true).pop();*/
            SharedInfo().sharedLoginSave(state.userModel);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
          } else if (state is LoadingState) {
            loadingDialog(context);
          } else if (state is LoginError) {
            _snackbar(state.message);
          }
        },
        child: Container(
          height: height,
          child: Stack(
            children: [
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              _content(height)
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(double height) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * .2),
            title(context, 30),
            SizedBox(height: 60),
            _loginForm(),
            SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Register',
                  style: mediumTextStyle(context, Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            _submitButton()
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) => emailValidator(value),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: textFieldStyle(context),
                decoration: textFieldDecoration('Email'),
                maxLines: 1,
                minLines: 1,
              ),
              TextFormField(
                validator: (value) => passwordValidator(value),
                controller: _passwordController,
                obscureText: true,
                decoration: textFieldDecoration('Password'),
                maxLines: 1,
                minLines: 1,
              )
            ],
          )),
    );
  }

  Widget _snackbar(String message) {
    print("print : $message");
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState.validate()) {
          _bloc.add(LoginEvent(
              email: _emailController.text,
              password: _passwordController.text));
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff29B6F6),
              Color(0xff81D4FA),
            ]),
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          "Login",
          style: biggerTextStyle(context, Colors.white),
        ),
      ),
    );
  }
}
