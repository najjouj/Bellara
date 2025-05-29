import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchFieldWidget extends StatefulWidget {
  final String fieldname;

  final Function callabckfunction;

  final List<String> items;
  const SearchFieldWidget(
      {super.key,
      required this.fieldname,
      required this.items,
      required this.callabckfunction});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                  color: Colors.grey.withOpacity(.2))
            ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: DropdownSearch<String>(
              items: widget.items,
              onChanged: (value) {
                setState(() {
                  selectedItem = value!;
                  widget.callabckfunction(value);
                });
              },
              selectedItem: selectedItem,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelStyle:
                      const TextStyle(fontSize: 24, color: Colors.blueGrey),
                  labelText: widget.fieldname,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  helperStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
              popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                modalBottomSheetProps:
                    ModalBottomSheetProps(backgroundColor: Colors.amber),
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rechercher..',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
                isFilterOnline: true,
                showSelectedItems: true,
                showSearchBox: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
