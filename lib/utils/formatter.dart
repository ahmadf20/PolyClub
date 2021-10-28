class Formatter {
  /// Abbreviation for name (only first two words)
  static String nameAbbr(String name) {
    String abbr = name.trim().split(' ').map((val) {
      if (val.isNotEmpty) return val[0].toUpperCase();
      return '';
    }).join();

    if (abbr.length > 2) return abbr.substring(0, 2);
    return abbr;
  }
}
