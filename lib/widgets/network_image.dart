import '../utils/custom_bot_toast.dart';
import '../values/const.dart';
import '../widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage(
    this.link, {
    Key? key,
    this.alignment,
    this.color,
    this.height,
    this.width,
    this.boxFit = BoxFit.cover,
    this.isShowLoading = true,
    this.hasErrorWidget = true,
    this.borderRadius = Const.defaultBRadius,
  }) : super(key: key);

  final String link;
  final bool isShowLoading;
  final Alignment? alignment;
  final bool hasErrorWidget;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          width: width,
          height: height,
          fit: boxFit,
          color: color,
          imageUrl: Uri.encodeFull(link),
          alignment: alignment ?? Alignment.center,
          placeholder: (context, url) {
            if (isShowLoading) {
              return MyLoadingIndicator.circular();
            } else {
              return Container();
            }
          },
          errorWidget: (context, url, error) => !hasErrorWidget
              ? Container()
              : Image.asset('assets/images/logo.png'),
        ),
      );
    } catch (e) {
      customBotToastText(ErrorMessage.general);
      return Image.asset('assets/images/logo.png');
    }
  }
}
