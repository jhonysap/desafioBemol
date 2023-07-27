import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.onChange,
  });

  final ValueChanged onChange;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: const EdgeInsets.only(top: 7),
        child: TextField(
          onChanged: widget.onChange,
          style: const TextStyle(color: Colors.black, fontSize: 20),
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Container(
                height: 60,
                child: const Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.black,
                ),
              ),
              hintText: 'Search Anything',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 20)),
        ),
      ),
    );
  }
}
