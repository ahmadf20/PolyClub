import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';
import 'package:poly_club/widgets/loading_indicator.dart';

Widget loadImage(
  String? linkGambar, {
  bool isShowLoading = true,
  Alignment alignment = Alignment.center,
  bool hasErrorWidget = true,
  Color? color,
  BoxFit boxFit = BoxFit.cover,
  double? width,
  double? height,
  String? baseUrl,
}) {
  if (linkGambar == null || linkGambar.isEmpty) {
    return Icon(Icons.error_outline);
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
            return Container();
          }
        },
        errorWidget: (context, url, error) =>
            !hasErrorWidget ? Container() : Icon(Icons.error_outline),
      );
      return image;
    } catch (e) {
      customBotToastText(ErrorMessage.general);
      return Icon(Icons.error_outline);
    }
  }
}
