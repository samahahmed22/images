import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../providers/images.dart';
import '../providers/image.dart' as img;
import '../widgets/image_item.dart';
import '../providers/auth.dart';

class SearchResultScreen extends StatefulWidget {
  static const routeName = '/search-result-screen';
  final String text;
  SearchResultScreen(this.text);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<img.Image> images = [];
  bool _isLoading = false;
  String searchText;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      double itemSize = width / 3;
      int perPage = (((height / itemSize).round()) + 1) * 3;

      searchText = widget.text;
      Provider.of<Images>(context, listen: false)
          .searchByImageTitle(searchText, perPage)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future _loadMore() async {
    // setState(() {
    //   _isLoading = true;
    // });
    await Provider.of<Images>(context, listen: false).fetchMoreData();
    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final userData = Provider.of<Auth>(context, listen: false);
    images = Provider.of<Images>(context).imagesList;
    return Scaffold(
        appBar: AppBar(
          title: Text(searchText),
          //  actions: <Widget>[
          //   Row(children: <Widget>[
          //     DropdownButton(
          //       icon: CircleAvatar(
          //         backgroundImage: NetworkImage(userData.user.photoURL),
          //       ),
          //       items: [
          //         DropdownMenuItem(
          //           child: Text('Logout'),
          //         ),
          //       ]),
          //     // SizedBox(width: 8),
          //     IconButton(
          //       icon: Icon(Icons.exit_to_app),
          //       onPressed: () async {
          //         await Provider.of<Auth>(context, listen: false).logout();
          //       },
          //     ),
          //     // SizedBox(width: 8),
          //   ]),
          // ]
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : LazyLoadScrollView(
                isLoading: _isLoading,
                onEndOfPage: () => _loadMore(),
                child: Scrollbar(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: images.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: images[i],
                      child: ImageItem(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                  ),
                ),
              ));
  }
}
