import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: "search book", border: InputBorder.none),
              )),
          InkWell(
              onTap: () {
                if (_searchController.text != "") {
                  /*FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    _bloc.add(FetchData(query: _searchController.text));
                  });*/
                }
              },
              child: Container(child: Icon(Icons.search)))
        ],
      ),
    );
  }
}
