import 'package:poly_club/values/const.dart';

import '../values/colors.dart';
import '../values/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldOutline extends StatelessWidget {
  const TextFieldOutline({
    Key? key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onClear,
    this.label,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength,
    this.contentPadding,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Function()? onClear;
  final String? label;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: MyTextStyle.body2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 10),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          style: MyTextStyle.body1.copyWith(color: Colors.black),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters ?? [],
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hintText,
            counter: Container(),
            hintStyle: MyTextStyle.body1.copyWith(
              color: MyColors.darkGrey,
            ),
            isDense: true,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
        ),
      ],
    );
  }
}
