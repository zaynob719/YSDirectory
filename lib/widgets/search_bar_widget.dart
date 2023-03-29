import 'package:flutter/material.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:coveredncurly/utils/utils.dart';

class SearchBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final bool hasBackButton;

  const SearchBarWidget({Key? key, required this.hasBackButton})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _showCancelButton = false;
  final TextEditingController _searchController = TextEditingController();

  OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.white,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      //decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                )
              : Container(),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.tagColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontFamily: 'GentiumPlus'),
                      focusNode: _focusNode,
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Find a Salon",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _showCancelButton = value.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  if (_showCancelButton)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _showCancelButton = false;
                          _focusNode.unfocus();
                        });
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
