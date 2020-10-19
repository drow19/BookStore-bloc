import 'package:bookstorebloc/bloc/cart/cart_bloc.dart';
import 'package:bookstorebloc/bloc/cart/cart_event.dart';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCartData extends StatefulWidget {
  final List<BookModel> list;

  ListCartData({@required this.list});

  @override
  _ListCartDataState createState() => _ListCartDataState();
}

class _ListCartDataState extends State<ListCartData> {
  CartBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: widget.list.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: ListTile(
                leading: Container(
                  width: 80,
                  height: 80,
                  child: CachedNetworkImage(
                      imageUrl:
                          '$base_url/book/image/${widget.list[index].photo}'),
                ),
                title: Text(
                  '${widget.list[index].title}',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text('\$${widget.list[index].prices}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff80deea),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _bloc.add(RemoveFromCart(index: index));
                    }),
              ),
            );
          }),
    );
  }
}
