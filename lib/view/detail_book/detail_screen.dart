import 'package:bookstorebloc/bloc/cart/cart_bloc.dart';
import 'package:bookstorebloc/bloc/cart/cart_event.dart';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:bookstorebloc/widget/star_display.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBook extends StatefulWidget {
  final BookModel bookModel;

  DetailBook({@required this.bookModel});

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _valueRating = [2, 3, 4, 5];
  var _reader = [23, 30, 39, 48, 40, 99, 100, 88, 236, 77, 19, 88];

  CartBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2)),
                        child: Material(
                          elevation: 15.0,
                          shadowColor: Colors.yellowAccent.shade200,
                          child: Hero(
                            tag: widget.bookModel.photo,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      '$base_url/book/image/${widget.bookModel.photo}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.bookModel.title}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                _rating(),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '\$${widget.bookModel.prices}',
                                  style: TextStyle(
                                    color: Color(0xff7e57c2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                _bloc.add(
                                    AddToCart(bookModel: widget.bookModel));
                                _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Added to cart...')));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 140,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.blue.shade700,
                                                spreadRadius: 1,
                                                offset: Offset(0, 3),
                                                blurRadius: 5)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.blue),
                                      child: Text('Add To Cart',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Text(
                    '${widget.bookModel.description}',
                    style: TextStyle(fontSize: 14.0, height: 1.5),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _rating() {
    int i = _valueRating[Random().nextInt(_valueRating.length)];
    int r = _reader[Random().nextInt(_reader.length)];
    return Container(
      child: Row(
        children: [
          StarDisplayWidget(color: Color(0xffFFD600), value: i),
          SizedBox(
            width: 5,
          ),
          Text(
            '$r ratings',
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
