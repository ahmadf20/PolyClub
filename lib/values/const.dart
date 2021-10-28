class Const {
  static String url = 'https://api-polyclub.herokuapp.com/api';
  // static String oneSignalAppId = 'aaeb1177-f822-40df-a27f-92d7d1d90bf6';
  static String oneSignalAppId = '65da08cc-eef6-40eb-b171-b8b574982b7f';

  /// To avoid FAB overlapping
  static const double bottomPadding = 65;

  /// To avoid FAB overlapping
  static const double bottomPaddingContentFAB = 90;

  /// Value for the bottom padding of buildtin FAB
  static const double bottomPaddingButton = 20; //50 for ios

  /// Default padding for screen / modals / dialog
  static const double screenPadding = 25;

  static const double defaultBRadius = 10;
  static const double mediumBRadius = 7.5;
  static const double smallBRadius = 5;

  static final String discordReport =
      'https://discord.com/api/webhooks/882619338778116096/3w8TD4_kRgtOuyNQON_5-JcuhSq9ioQJwahyFavYcb2v21ic9_RMw0ZR4VvEyHbdZeo8';
}

class ErrorMessage {
  static String general = 'Terjadi kesalahan';
  static String connection = 'Kesalahan jaringan';
}
