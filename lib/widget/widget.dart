import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget title(BuildContext context, double size) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'B',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: size,
          fontWeight: FontWeight.w700,
          color: Color(0xff00897B),
        ),
        children: [
          TextSpan(
            text: 'ook',
            style: TextStyle(color: Colors.black, fontSize: size),
          ),
          TextSpan(
            text: 'App',
            style: TextStyle(color: Color(0xff039BE5), fontSize: size),
          ),
        ]),
  );
}

InputDecoration textFieldDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.black),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  );
}

TextStyle textFieldStyle(BuildContext context) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black);
}

TextStyle smallTextStyle(BuildContext context, Color colors) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colors);
}

TextStyle mediumTextStyle(BuildContext context, Color colors) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: colors);
}

TextStyle biggerTextStyle(BuildContext context, Color colors) {
  return GoogleFonts.roboto(
      textStyle: Theme.of(context).textTheme.display1,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: colors);
}

//loading widget
void loadingDialog(BuildContext context){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return CupertinoAlertDialog(
          title: Text("Loading..."),
          content: CupertinoActivityIndicator(radius: 15,),
        );
      }
  );
}

Widget _loading(){
  return Container(
    color: Color(0xff000000).withOpacity(0.7),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
