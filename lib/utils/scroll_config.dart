//remove scroll bound effect
import 'package:flutter/material.dart';

class NoGlowScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      showLeading: false,
      showTrailing: false,
      color: Colors.grey[300]!,
      child: child,
    );
  }
}
