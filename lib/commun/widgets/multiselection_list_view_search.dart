import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiselectionListViewSearch extends StatefulWidget {
  final List<String> items;
  final Function stringCallback;
  const MultiselectionListViewSearch(
      {super.key, required this.items, required this.stringCallback});

  @override
  State<MultiselectionListViewSearch> createState() =>
      _MultiselectionListViewSearchState();
}

class _MultiselectionListViewSearchState
    extends State<MultiselectionListViewSearch> {
  List<Map<String, dynamic>> searchResult = [];
  List<String> searchList = [];
  List<String> selections = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      searchResult.add({'value': widget.items[i], 'tapped': false});
    }
    searchList.addAll(widget.items);
  }

  void _runFilter(String keyWord) {
    if (keyWord.isEmpty) {
      searchResult = [];
      for (int i = 0; i < widget.items.length; i++) {
        searchResult.add({'value': widget.items[i], 'tapped': false});
      }
    } else {
      searchList = widget.items
          .where((e) => e.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
      for (int i = 0; i < searchList.length; i++) {
        searchResult.add({'value': searchList[i], 'tapped': true});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: GestureDetector(
            onTap: () {
              for (int i = 0; i < searchResult.length; i++) {
                if (searchResult[i]['tapped']) {
                  selections.add(searchResult[i]['value']);
                }
              }
              widget.stringCallback(selections);
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          width: double.infinity,
          height: 50,
          child: TextField(
            decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                ),
                fillColor: Colors.white,
                filled: true,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.all(15),
                hintText: 'rechercher',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(80))),
            onChanged: (value) {
              _runFilter(value);
              setState(() {});
            },
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: ListView.builder(
            itemCount: searchResult.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    searchResult[index]['tapped'] =
                        !searchResult[index]['tapped'];
                  });
                  // Get.back();
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        border: searchResult[index]['tapped']
                            ? Border.all(color: Colors.deepPurple)
                            : null,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      searchResult[index]['value'],
                    )),
              );
            }),
      ),
    );
  }
}
