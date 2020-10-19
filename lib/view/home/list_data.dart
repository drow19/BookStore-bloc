import 'package:bookstorebloc/bloc/cart/cart_bloc.dart';
import 'package:bookstorebloc/bloc/cart/cart_event.dart';
import 'package:bookstorebloc/bloc/home/home_bloc.dart';
import 'package:bookstorebloc/bloc/home/home_event.dart';
import 'package:bookstorebloc/bloc/home/home_state.dart';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/book_model.dart';
import 'package:bookstorebloc/view/detail_book/detail_screen.dart';
import 'package:bookstorebloc/widget/star_display.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDataBook extends StatefulWidget {

  @override
  _ListDataBookState createState() => _ListDataBookState();
}

class _ListDataBookState extends State<ListDataBook> {
  ScrollController _scrollController = ScrollController();
  var _valueRating = [2, 3, 4, 5];

  List<BookModel> data = new List();
  CartBloc _cart;
  HomeBloc _bloc;

  int page = 1;

  _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      page++;
      print('$page');
      _bloc.add(OnScrollPage(page: page, data: data));
    }
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _cart = BlocProvider.of<CartBloc>(context);
    _scrollController.addListener(_onScroll);
    _bloc.add(IsFetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: _bloc,
        // ignore: missing_return
        builder: (ctx, state) {
          if (state is FetchData) {
            data = state.list;
            return _listBook(state.list);
          } else if (state is IsLoadingHomeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is IsErrorHomeState) {
            return Center(
              child: Text(state.message),
            );
          }
        });
  }

  Widget _listBook(List<BookModel> list) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: list.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) =>
                          DetailBook(
                            bookModel: list[index],
                          )));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(color: Color(0xffffffff), blurRadius: 2.0)
                  ]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: 100,
                      child: Hero(
                        tag: list[index].photo,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              imageUrl:
                              '$base_url/book/image/${list[index]
                                  .photo}'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${list[index].title}',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xff000000),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${list[index].description}',
                            style: TextStyle(
                                fontFamily: 'Spectral',
                                color: Color(0xff000000),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          ListCategory(),
                          StarDisplayWidget(
                            color: Color(0xffffd600),
                            value: _valueRating[
                            Random().nextInt(_valueRating.length)],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${list[index].prices}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xff7E57C2),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _cart.add(AddToCart(
                                      bookModel: list[index]));
                                  Scaffold.of(context).showSnackBar(
                                      new SnackBar(
                                          duration: Duration(seconds: 1),
                                          content:
                                          Text('Added to cart...')));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Color(0xff80deea),
                                      borderRadius:
                                      BorderRadius.circular(8)),
                                  child: Text(
                                    'Add To Chart',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffffffff)),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ListCategory extends StatelessWidget {
  var _category = ["Science", "Biography", "Education", "Technology"];
  final _random = new Random();

  @override
  Widget build(BuildContext context) {
    int next(int min, int max) => min + _random.nextInt(max - min);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Color(0xffC5CAE9), borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: Text(
            _category[next(0, 3)],
            style: TextStyle(fontSize: 13),
          )),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Color(0xffC5CAE9), borderRadius: BorderRadius.circular(8)),
          child: Center(
              child:
                  Text(_category[next(0, 3)], style: TextStyle(fontSize: 13))),
        ),
      ],
    );
  }
}
