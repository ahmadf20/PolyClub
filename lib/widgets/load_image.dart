import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/values/text_style.dart';
import 'package:poly_club/widgets/loading_indicator.dart';

Widget loadImage(
  String? linkGambar, {
  bool isShowLoading = false,
  Alignment alignment = Alignment.center,
  bool hasErrorWidget = true,
  Color? color,
  BoxFit boxFit = BoxFit.cover,
  double? width,
  double? height,
  String? baseUrl,
  String? errorImagePath,
  String? initials,
}) {
  if (linkGambar == null || linkGambar.isEmpty) {
    return _errorWidget(
        hasErrorWidget, errorImagePath, height, width, initials);
  } else {
    try {
      Widget image = CachedNetworkImage(
        fit: boxFit,
        color: color,
        height: height,
        width: width,
        imageUrl: Uri.encodeFull(baseUrl ?? '' '$linkGambar'),
        alignment: alignment,
        placeholder: (context, url) {
          if (isShowLoading) {
            return MyLoadingIndicator.circular();
          } else {
            return _errorWidget(
                hasErrorWidget, errorImagePath, height, width, initials);
          }
        },
        errorWidget: (context, url, error) => _errorWidget(
            hasErrorWidget, errorImagePath, height, width, initials),
      );
      return image;
    } catch (e) {
      customBotToastText(ErrorMessage.general);
      return _errorWidget(
          hasErrorWidget, errorImagePath, height, width, initials);
    }
  }
}

Widget _errorWidget(
    bool hasErrorWidget, errorImagePath, height, width, String? text) {
  if (!hasErrorWidget) {
    return Container();
  } else {
    if (errorImagePath != null) {
      return Image.asset(
        errorImagePath,
        height: height,
        width: width,
      );
    } else {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: MyColors.lightGrey,
          borderRadius: BorderRadius.circular(Const.smallBRadius),
        ),
        child: Center(
            child: Text(
          text ?? '',
          style: MyTextStyle.bodySemibold1.copyWith(fontSize: height / 2.5),
        )),
      );
    }
  }
}
