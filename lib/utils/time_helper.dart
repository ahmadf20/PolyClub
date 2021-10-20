class TimeHelper {
  /// convert `time` (string) to `DateTime`
  /// usually be `HH:mm:ss`. Ex: `08:00:00`
  /// return `null` if time is wrong formatted
  static DateTime? getDateTimefromTime(String timeString) {
    DateTime now = DateTime.now();

    if (!RegExp(r'\d{2}:\d{2}:\d{2}').hasMatch(timeString)) {
      return null;
    }

    return DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeString.split(':')[0]),
        int.parse(timeString.split(':')[1]));
  }
}
