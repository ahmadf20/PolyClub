import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poly_club/utils/custom_bot_toast.dart';
import 'package:poly_club/values/const.dart';
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
}) {
  if (linkGambar == null || linkGambar.isEmpty) {
    return _errorWidget(hasErrorWidget, errorImagePath, height, width);
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
            return (errorImagePath != null
                ? Image.asset(
                    errorImagePath,
                    height: height,
                    width: width,
                  )
                : Icon(Icons.error_outline));
          }
        },
        errorWidget: (context, url, error) =>
            _errorWidget(hasErrorWidget, errorImagePath, height, width),
      );
      return image;
    } catch (e) {
      customBotToastText(ErrorMessage.general);
      return _errorWidget(hasErrorWidget, errorImagePath, height, width);
    }
  }
}

Widget _errorWidget(bool hasErrorWidget, errorImagePath, height, width) {
  if (!hasErrorWidget) {
    return Container();
  } else {
    return (errorImagePath != null
        ? Image.asset(
            errorImagePath,
            height: height,
            width: width,
          )
        : Icon(Icons.error_outline));
  }
}
