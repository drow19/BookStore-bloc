import 'package:bookstorebloc/bloc/history/detail/bloc.dart';
import 'package:bookstorebloc/bloc/history/detail/detail_event.dart';
import 'package:bookstorebloc/bloc/history/detail/detail_state.dart';
import 'package:bookstorebloc/helper/base_url.dart';
import 'package:bookstorebloc/model/history_model.dart';
import 'package:bookstorebloc/view/home/list_data.dart';
import 'package:bookstorebloc/widget/star_display.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailTransScreen extends StatefulWidget {
  final transId;
  final date;
  final total;

  DetailTransScreen(
      {@required this.transId, @required this.date, @required this.total});

  @override
  _DetailTransScreenState createState() => _DetailTransScreenState();
}

class _DetailTransScreenState extends State<DetailTransScreen> {
  DetailBloc _bloc;
  var _valueRating = [2, 3, 4, 5];

  @override
  void initState() {
    _bloc = BlocProvider.of<DetailBloc>(context);
    _bloc.add(FetchDataEvent(transId: widget.transId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder<DetailBloc, DetailState>(
                // ignore: missing_return
                builder: (context, state) {
              if (state is IsLoadedState) {
                return _listBook(state.list);
              } else if (state is IsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is IsErrorState) {
                print(state.message);
                return Center(
                  child: Text('${state.message}'),
                );
              }
            }),
          ),
          Container(
            color: Colors.white38,
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      '${widget.date}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      '\$${widget.total}'.replaceAll(',', '.'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listBook(List<DetailTransactionModel> list) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                      imageUrl: '$base_url/book/image/${list[index].photo}'),
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
                      value:
                          _valueRating[Random().nextInt(_valueRating.length)],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
