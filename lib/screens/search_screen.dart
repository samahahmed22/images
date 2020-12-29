import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();

  List<dynamic> searchHistory = [];
  List<dynamic> items = [];
  String searchText;
  @override
  void initState() {
    final prefs = SharedPreferences.getInstance().then((value) {
      // value.remove('searchData');
      if (value.containsKey('searchData')) {
        searchHistory = json.decode(value.getString('searchData'));
        setState(() {
          items.addAll(searchHistory);
        });
      }
    });
  }

  void filterSearchResults(String query) {
    List<String> searchHistoryList = [];
    if (query.isNotEmpty) {
      searchHistory.forEach((item) {
        if (item.toUpperCase().contains(query.toUpperCase())) {
          searchHistoryList.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(searchHistoryList);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(searchHistory);
      });
    }
  }

  void saveSearchText() async {
    final prefs = await SharedPreferences.getInstance();
    if (!searchHistory.contains(searchText) &&
        searchText != null &&
        searchText.trim().length > 0) {
      searchHistory.add(searchText);
      prefs.setString('searchData', json.encode(searchHistory));
    }

    Navigator.of(context).pushNamed(
      'search',
      arguments: searchText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for flicker images'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      searchText = value;
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ))),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () => saveSearchText()),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                    subtitle: Text(""),
                    leading: Icon(Icons.history),
                    isThreeLine: true,
                    onTap: () {
                      setState(() {
                        searchText = items[index];
                        editingController.text = searchText;
                      });
                      filterSearchResults(items[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
