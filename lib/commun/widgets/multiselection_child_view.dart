import 'package:bellaraa/mobileLayout/users/welcomeScreens/frontend/widgets/child_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildMultiselectionListViewSearch extends StatefulWidget {
  final List<dynamic> items;
  final Function stringCallback;
  const ChildMultiselectionListViewSearch(
      {super.key, required this.items, required this.stringCallback});

  @override
  State<ChildMultiselectionListViewSearch> createState() =>
      _ChildMultiselectionListViewSearchState();
}

class _ChildMultiselectionListViewSearchState
    extends State<ChildMultiselectionListViewSearch> {
  List<dynamic> searchResult = [];
  // List<dynamic> searchList = [];
  List<dynamic> selections = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchResult.addAll(widget.items);
  }

  void _runFilter(String keyWord) {
    if (keyWord.isEmpty) {
      searchResult = [];
      searchResult.addAll(widget.items);
    } else {
      searchResult = widget.items
          .where((e) => e['nom'].toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
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
                  selections.add(searchResult[i]);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChildCard(child: searchResult[index]),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
