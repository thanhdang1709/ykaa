import 'package:intl/intl.dart';

class $Time {
  static timestampToDate(timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return date;
  }
}

class $Datetime {
  static int dateTimeToTimestamp(DateTime datetime) => (datetime.millisecondsSinceEpoch / 1000).floor();

  static DateTime timestampToDateTime(int timestamp) {
    int timestampCuted = int.parse(timestamp.toString().substring(0, 10));

    return DateTime.fromMillisecondsSinceEpoch(timestampCuted * 1000);
  }

  static String format(DateTime datetime, String formatStyle) {
    return DateFormat(formatStyle).format(datetime);
  }

  static String formatFromTimestamp(int timestamp, String formatStyle) {
    DateTime datetime = $Datetime.timestampToDateTime(timestamp);
    return DateFormat(formatStyle).format(datetime);
  }

  static String formatFromString(String datetime, String formatStyle) {
    return DateFormat(formatStyle).format(DateTime.parse(datetime));
  }

  static DateTime stringToDateTime(String datetimeString) {
    return DateTime.parse(datetimeString);
  }

  static getCurrentTimestamp() => (DateTime.now().millisecondsSinceEpoch / 1000).floor();

  static DateTime replace(DateTime datetime, {int year, int month, int day, int hour, int minute, int second, int millisecond, int microsecond}) {
    return DateTime(
      year ?? datetime.year,
      month ?? datetime.month,
      day ?? datetime.day,
      hour ?? datetime.hour,
      minute ?? datetime.minute,
      second ?? datetime.second,
      millisecond ?? datetime.millisecond,
      microsecond ?? datetime.microsecond,
    );
  }

  static String getLabelFromDateTime(
    DateTime datetime, {
    bool isOnlyDayName = false,
    String middle = " -",
  }) {
    DateTime now = $Datetime.replace(DateTime.now(), hour: 0, minute: 0, second: 0);
    DateTime dateCompare = $Datetime.replace(datetime, hour: 0, minute: 0, second: 0);

    int difference = now.difference(dateCompare).inHours;
    String label = "";

    if (difference == -23) {
      label = "Ng??y mai";
    } else if (difference == 0) {
      label = "H??m nay";
    } else if (difference == 24) {
      label = "H??m qua";
    } else {
      Map daysName = {
        1: "Th??? hai",
        2: "Th??? ba",
        3: "Th??? t??",
        4: "Th??? n??m",
        5: "Th??? s??u",
        6: "Th??? b???y",
        7: "Ch??? nh???t",
      };

      label = daysName[datetime.weekday];
    }

    String result = label;

    if (!isOnlyDayName) {
      result += "$middle ${$Datetime.format(datetime, 'dd/MM/yyyy')}";
    }

    return result;
  }
}
