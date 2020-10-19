import 'package:bookstorebloc/bloc/history/bloc.dart';
import 'package:bookstorebloc/bloc/history/history_event.dart';
import 'package:bookstorebloc/bloc/history/history_state.dart';
import 'package:bookstorebloc/model/history_model.dart';
import 'package:bookstorebloc/view/history/detail_transaction_screen.dart';
import 'package:bookstorebloc/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ScrollController _scrollController = ScrollController();
  List<HistoryModel> data = new List();
  HistoryBloc _bloc;
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
    _bloc = BlocProvider.of<HistoryBloc>(context);
    _scrollController.addListener(_onScroll);
    _bloc.add(IsFetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (contex) => HomeScreen()));
            }),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Row(
              children: [
                Text(
                  'History Transaction',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<HistoryBloc, HistoryState>(
                // ignore: missing_return
                builder: (ctx, state) {
              if (state is IsLoadedState) {
                data = state.list;
                return _listTransaction(state.list);
              } else if (state is IsloadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is IsErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
            }),
          )
        ],
      ),
    );
  }

  Widget _listTransaction(List<HistoryModel> list) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => DetailTransScreen(
                      transId: list[index].transId,
                      date: list[index].date,
                      total: list[index].total,
                    ),
                  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${list[index].transId}'),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\$ ${list[index].total}'.replaceAll(',', '.'),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xff7E57C2),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text('${list[index].date}'),
                  Divider(
                    thickness: 1,
                  )
                ],
              ),
            ),
          );
        });
  }
}
