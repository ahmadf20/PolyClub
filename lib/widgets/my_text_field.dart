import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/text_style.dart';

class MyTextField extends StatelessWidget {
  final String? label;
  final bool obscureText;
  final String? errorText;
  final String? hintText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function? onChanged;
  final TextStyle? inputTextStyle;
  final bool autoFocus;
  final int minLines;
  final int maxLines;
  final TextInputType textInputType;
  final bool enabled;
  final Function? onTap;

  const MyTextField({
    Key? key,
    this.label,
    this.obscureText = false,
    this.controller,
    this.errorText,
    this.validator,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.onChanged,
    this.fillColor,
    this.inputTextStyle,
    this.autoFocus = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.textInputType = TextInputType.text,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: MyTextStyle.textFieldLabel,
          ),
          SizedBox(height: 7),
        ],
        Container(
          padding: EdgeInsets.all(7.5),
          decoration: BoxDecoration(
            color: fillColor ?? MyColors.lighterGrey,
            border: Border.all(
              width: 1.00,
              color: MyColors.lightGrey,
            ),
            borderRadius: BorderRadius.circular(Const.mediumBRadius),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: !enabled,
            onTap: onTap as void Function()?,
            onChanged: onChanged as void Function(String)?,
            obscureText: obscureText,
            style: MyTextStyle.body1
                .copyWith(
                  fontFamily: 'GeneralSans',
                  color: MyColors.darkerGrey,
                  fontWeight: FontWeight.w500,
                  // height: 0.8,
                )
                .merge(inputTextStyle),
            minLines: minLines,
            maxLines: minLines > maxLines ? minLines : maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: autoFocus,
            validator: validator,
            keyboardType: textInputType,
            inputFormatters: [
              if (textInputType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              // labelStyle: TextStyle(
              //   fontFamily: 'OpenSans',
              //   color: MyColors.grey,
              //   height: 0.8,
              // ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              fillColor: fillColor ?? MyColors.lighterGrey,
              filled: true,
              contentPadding: EdgeInsets.all(7.5),
              border: InputBorder.none,
              suffix: suffix,
              suffixIcon: suffixIcon == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(right: 7.5),
                      child: suffixIcon,
                    ),
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 48, minHeight: 24),
              isDense: true,
              // labelText: label,
              errorText: errorText,
              hintText: hintText,
              hintStyle: MyTextStyle.body1.copyWith(
                fontFamily: 'GeneralSans',
                color: MyColors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
