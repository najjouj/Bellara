import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListViewSearchScreen extends StatefulWidget {
  final List<String> items;
  final Function stringCallback;
  const ListViewSearchScreen(
      {super.key, required this.items, required this.stringCallback});

  @override
  State<ListViewSearchScreen> createState() => _ListViewSearchScreenState();
}

class _ListViewSearchScreenState extends State<ListViewSearchScreen> {
  List<String> searchResult = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchResult.addAll(widget.items);
  }

  void _runFilter(String keyWord) {
    if (keyWord.isEmpty) {
      searchResult = widget.items;
    } else {
      searchResult = widget.items
          .where((e) => e.toLowerCase().contains(keyWord.toLowerCase()))
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
                    widget.stringCallback(searchResult[index]);
                  });
                  Get.back();
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      searchResult[index],
                    )),
              );
            }),
      ),
    );
  }
}
