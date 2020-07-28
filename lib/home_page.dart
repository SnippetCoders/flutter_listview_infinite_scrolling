import 'package:flutter/material.dart';
import 'package:flutter_listview_infinite_scrolling/provider/data_provider.dart';
import 'package:provider/provider.dart';

import 'models/data_model.dart' as RadioModel;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  int _page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    var videosBloc = Provider.of<DataProvider>(context, listen: false);
    videosBloc.resetStreams();
    videosBloc.fetchAllUsers(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        videosBloc.setLoadingState(LoadMoreStatus.LOADING);
        videosBloc.fetchAllUsers(++_page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Infinite Scrolling"),
      ),
      body: Consumer<DataProvider>(
        builder: (context, usersModel, child) {
          if (usersModel.allUsers != null && usersModel.allUsers.length > 0) {
            return _listView(usersModel);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _listView(DataProvider dataProvider) {
    return 
        ListView.separated(
          itemCount: dataProvider.allUsers.length,
          controller: _scrollController,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if ((index == dataProvider.allUsers.length - 1) &&
                dataProvider.allUsers.length < dataProvider.totalRecords) {
              return Center(child: CircularProgressIndicator());
            }

            return _buildRow(dataProvider.allUsers[index]);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
  }

  Widget _buildRow(RadioModel.Radio radioModel) {
    return ListTile(title: new Text(radioModel.radioName));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
