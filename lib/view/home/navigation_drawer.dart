import 'package:bookstorebloc/bloc/auth/auth_bloc.dart';
import 'package:bookstorebloc/bloc/auth/auth_event.dart';
import 'package:bookstorebloc/view/cart/cart_screen.dart';
import 'package:bookstorebloc/view/history/history_screen.dart';
import 'package:bookstorebloc/view/home/home_screen.dart';
import 'file:///C:/Users/Drow/AndroidStudioProjects/bookstore_bloc/lib/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<Map> drawerList = [
    {
      'name': 'Home',
      'icon': Icon(
        Icons.home,
        color: Colors.black,
      )
    },
    {'name': 'History', 'icon': Icon(Icons.history, color: Colors.black)},
    {'name': 'Cart', 'icon': Icon(Icons.shopping_cart, color: Colors.black)},
  ];

  AuthBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: drawerList
                .map((e) => GestureDetector(
                      onTap: () {
                        if (e['name'] == 'Home') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => HomeScreen()));
                        } else if (e['name'] == 'History') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => HistoryScreen()));
                        } else if (e['name'] == 'Cart') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => CartScreen()));
                        }
                      },
                      child: Container(
                        width: 250,
                        child: ListTile(
                          leading: e['icon'],
                          title: Text(
                            e['name'],
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          GestureDetector(
            onTap: () {
              _bloc.add(LogoutEvent());
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (contex) => LoginScreen()));
            },
            child: Container(
              width: 250,
              margin: EdgeInsets.only(bottom: 30),
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
