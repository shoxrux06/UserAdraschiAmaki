import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatefulWidget {
  final Function(String searchText) search;

  const SearchBar({Key? key, required this.search}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      widget.search(_searchController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
      height: 50,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Container(padding: EdgeInsets.all(15), child: SvgPicture.asset("assets/icons/search_i.svg", width: 20, height: 20)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          hintText: "search".tr(),
          hintStyle: TextStyle(fontSize: 15)
        ),
      ),
    );
  }
}
