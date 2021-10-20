import 'package:poly_club/values/const.dart';

import '../values/colors.dart';
import '../values/text_style.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    Key? key,
    required this.filterController,
    this.hintText,
    this.onChanged,
    this.onClear,
  }) : super(key: key);

  final TextEditingController filterController;
  final String? hintText;
  final Function(String)? onChanged;
  final Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: filterController,
      onChanged: onChanged,
      style: MyTextStyle.body2.copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: MyTextStyle.body2.copyWith(
          color: MyColors.darkGrey,
        ),
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onClear,
              icon: Icon(Icons.close_rounded),
              color: MyColors.darkGrey,
            ),
            Container(
              decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(Const.defaultBRadius),
              ),
              padding: EdgeInsets.all(12.5),
              child: Icon(
                Icons.search,
                color: MyColors.white,
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.midGrey,
          ),
          borderRadius: BorderRadius.circular(Const.defaultBRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: MyColors.primary,
          ),
          borderRadius: BorderRadius.circular(Const.defaultBRadius),
        ),
      ),
    );
  }
}
