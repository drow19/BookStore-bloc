import 'package:bookstorebloc/bloc/cart/cart_bloc.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:bookstorebloc/view/cart/cart_screen.dart';
import 'package:bookstorebloc/view/home/list_data.dart';
import 'package:bookstorebloc/view/home/navigation_drawer.dart';
import 'package:bookstorebloc/view/home/search.dart';
import 'package:bookstorebloc/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_badge/icon_badge.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  CartBloc _cart;

  @override
  void initState() {
    _cart = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  /*double tap back button to exit app using onWillScope*/
  /*Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      var snakBar = SnackBar(content: Text('Pressed again to exit app'));
      _scaffoldKey.currentState.showSnackBar(snakBar);
      *//*Fluttertoast.showToast(msg: exit_warning);*//*
      return Future.value(false);
    }
    return Future.value(true);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: BlocBuilder<CartBloc, List<BookModel>>(
            // ignore: missing_return
            builder: (context, book) {
          if (book.length != null) {
            return IconBadge(
              itemCount: book.length,
              right: 0,
              top: 5,
              hideZero: true,
              icon: Icon(
                Icons.shopping_cart,
              ),
              onTap: () {
                if (book.length != 0) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                }
              },
            );
          }
        }),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff).withOpacity(0.1),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: isDrawerOpen
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xff000000),
                ),
                onPressed: () {
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    scaleFactor = 1;
                    isDrawerOpen = false;
                  });
                })
            : Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Color(0xff000000),
                      ),
                      onPressed: () {
                        setState(() {
                          xOffset = 230;
                          yOffset = 150;
                          scaleFactor = 0.6;
                          isDrawerOpen = true;
                        });
                      }),
                  title(context, 20)
                ],
              ),
      ),
      body: Stack(
        children: [
          isDrawerOpen ? NavigationDrawer() : Container(),
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            child: Container(
              child: Column(
                children: [
                  Search(),
                  Expanded(
                    child: ListDataBook(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
