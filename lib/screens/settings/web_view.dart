import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:poly_club/widgets/page_title.dart';
import '../../values/const.dart';
import '../../widgets/unfocus_wrapper.dart';

class WebViewScreen extends StatelessWidget {
  WebViewScreen({
    Key? key,
    this.data = '',
    this.title = '',
  }) : super(key: key);

  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(Const.screenPadding)
                .copyWith(top: 10, bottom: 0),
            child: PageTitle(title: title),
          ),
          Expanded(
            child: InAppWebView(
              key: ValueKey(data),
              initialUrlRequest: URLRequest(url: Uri.parse(data)),
            ),
          ),
        ],
      ),
    );
  }
}
