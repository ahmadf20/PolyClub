import '../utils/scroll_config.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? title, buttonText, subtitle;
  final IconData? icon, iconButton;
  final Widget? child;
  final bool hasButtonIcon;
  final bool hasButton;

  final Function()? onPressed;

  const ErrorScreen(
      {this.title,
      this.icon,
      this.child,
      this.onPressed,
      this.buttonText,
      this.iconButton,
      this.subtitle,
      this.hasButtonIcon = true,
      this.hasButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(40),
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon ?? Icons.error_outline,
                size: 75,
                color: Colors.grey,
              ),
              SizedBox(height: 25),
              title == null
                  ? Container()
                  : Text(
                      title!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
              subtitle == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        subtitle!,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
              SizedBox(height: 25),
              if (hasButton)
                OutlineButton(
                  highlightedBorderColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      hasButtonIcon
                          ? Icon(
                              iconButton ?? Icons.arrow_back,
                              color: Colors.grey,
                            )
                          : Container(),
                      SizedBox(width: 5),
                      Text(
                        buttonText ?? 'Kembali',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  onPressed: onPressed ?? () => Navigator.maybePop(context),
                )
            ],
          ),
        ),
      ),
    );
  }
}
