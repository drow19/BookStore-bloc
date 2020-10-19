import 'package:bookstorebloc/bloc/cart/cart_bloc.dart';
import 'package:bookstorebloc/bloc/cart/cart_event.dart';
import 'package:bookstorebloc/bloc/transaction/bloc.dart';
import 'package:bookstorebloc/bloc/transaction/transaction_event.dart';
import 'package:bookstorebloc/bloc/transaction/transaction_state.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:bookstorebloc/view/cart/list_cart.dart';
import 'package:bookstorebloc/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CartBloc _cartBloc;
  TransactionBloc _transactionBloc;
  int total;
  List<BookModel> list = new List<BookModel>();

  @override
  Widget build(BuildContext context) {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _transactionBloc = BlocProvider.of<TransactionBloc>(context);
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionIsLoading) {
          loadingDialog(context);
        } else if (state is TransactionIsSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          if (state.message == '1') {
            _cartBloc.add(ClearCart());
            final _snackBar = SnackBar(
              content: Text('Success'),
              duration: new Duration(seconds: 2),
            );
            _scaffoldKey.currentState.showSnackBar(_snackBar);
          } else {
            final _snackBar = SnackBar(content: Text('Failed'));
            _scaffoldKey.currentState.showSnackBar(_snackBar);
          }
        } else if (state is TransactionIsError) {
          final _snackBar = SnackBar(
              content: Text(
                '${state.message}',
              ),
              duration: new Duration(seconds: 2));
          Scaffold.of(context).showSnackBar(_snackBar);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<CartBloc, List<BookModel>>(
                // ignore: missing_return
                builder: (context, book) {
              if (book.length > 0) {
                return Expanded(child: ListCartData(list: book));
              } else {
                return Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Cart Is Empty',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }
            }),
            Container(
              height: 100,
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                    title: Text("Total",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        )),
                    trailing: BlocBuilder<CartBloc, List<BookModel>>(
                        builder: (context, book) {
                      total = 0;
                      list = book;
                      for (int i = 0; i < book.length; i++) {
                        total = total + book[i].prices;
                      }
                      if (book.length > 0) {
                        return Text('\$$total');
                      } else {
                        return Text('0');
                      }
                    }),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        _transactionBloc.add(PostTransaction(book: list));
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        margin: EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          'Buy',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
