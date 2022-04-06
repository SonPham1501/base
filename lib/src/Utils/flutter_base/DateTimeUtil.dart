import 'package:intl/intl.dart';

class DateTimeUtil {
  static String? dateTimeToString(DateTime? dateTime, String format) {
    if (dateTime == null) return null;
    var formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  static DateTime? stringToDateTime(String? dateTimeString, String format) {
    if (dateTimeString == null) return null;
    var formatter = DateFormat(format);
    return formatter.parse(dateTimeString);
  }

  static DateTime getDateTimeLaterYear(DateTime dateTime, int value) {
    return DateTime(dateTime.year + value, dateTime.month, dateTime.day);
  }

  static DateTime getDateTimeLaterMinute(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute + value);
  }

  static DateTime getDateTimeLaterHour(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour + value);
  }

  static DateTime getDateTimeLaterDay(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day + value);
  }

  static DateTime getDateTimeLaterMonth(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month + value, dateTime.day);
  }

  static String? getDateShowWithString(String? dateTime) {
    if (dateTime == null) return '';
    var _dateTime = DateTime.tryParse(dateTime);
    if (_dateTime == null) return '';
    return dateTimeToString(_dateTime, "dd/MM/yyyy");
  }

  static String? getDateTimeShowWithString(String? dateTime) {
    if (dateTime == null) return '';
    var _dateTime = DateTime.tryParse(dateTime);
    if (_dateTime == null) return '';
    return dateTimeToString(_dateTime, "HH:mm dd/MM/yyyy");
  }

  static String? getDateTimeServerToDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return dateTimeToString(dateTime, "yyyy-MM-dd'T'HH:mm:ss.SSS");
  }

  static String? getDateTimeSendServer(String dateTimeString) {
    var dateTime = stringToDateTime(dateTimeString, "HH:mm dd-MM-yyyy");
    return dateTimeToString(dateTime, "yyyy-MM-dd'T'HH:mm:ss.SSS");
  }

  static String? getDateTimeStringServer(DateTime dateTime) {
    return dateTimeToString(dateTime, "yyyy-MM-dd'T'HH:mm:ss");
  }

  static String? getDateTimePayment(DateTime dateTime, {int hour = 0}) {
    dateTime = dateTime.subtract(Duration(hours: hour));
    return dateTimeToString(dateTime, "dd/MM/yyyy' 'HH:mm");
  }

  static String? getDateTimeInteractive(DateTime? dateTime) {
    if (dateTime == null) return '';
    return ' (${dateTimeToString(dateTime, "HH:mm '-' dd/MM/yyyy") ?? ""})';
  }

  static String? getDateTimeStamp(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return dateTimeToString(dateTime, "dd/MM/yyyy");
  }

  static String? getDateTimeToDate(DateTime? dateTime) {
    if (dateTime == null) return "";
    return dateTimeToString(dateTime, "dd/MM/yyyy");
  }

  static String? getDateTimeFormat(DateTime? dateTime, String format) {
    if (dateTime == null) return null;
    return dateTimeToString(dateTime, format);
  }

  static String? getDateTimeTHG(String? dateTimeString) {
    if (dateTimeString == null) return "";
    if (dateTimeString.isEmpty) return "";
    var dateTime = stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss");
    return getFullDate(dateTime);
  }

  static String? getFullDate(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.day.toString() + " thg " + dateTime.month.toString() + ", " + dateTime.year.toString();
  }

  static String? getFullDateAndTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString() +
        " - " +
        dateTime.hour.toString() +
        ":" +
        dateTime.minute.toString();
  }

  static String? getFullDateAndTimeSecond(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString() +
        " - " +
        dateTime.hour.toString() +
        ":" +
        dateTime.minute.toString() +
        ":" +
        dateTime.second.toString();
  }

  static String getFullTime(DateTime dateTime) {
    return dateTime.hour.toString() + " : " + dateTime.minute.toString();
  }

  static String? getFullDateTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.day.toString() +
        " thg " +
        dateTime.month.toString() +
        ", " +
        dateTime.year.toString() +
        ", " +
        dateTimeToString(dateTime, "HH:mm:ss")!;
  }

  static DateTime getDateTimeStartDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0);
  }

  static DateTime getDateTimeEndDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 0, 0);
  }

  static int getTimeStamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  static bool isSameDate(DateTime? date1, DateTime? date2) {
    if (date1 == null && date2 == null) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  static int isSameOnlyHourAndMinute(DateTime? date1, DateTime? date2) {
    if (date1 == null && date2 == null) {
      return 0;
    }
    if (date1 == null || date2 == null) {
      return 0;
    }
    if (date1.hour > date2.hour) {
      return 1;
    }
    if (date1.hour < date2.hour) {
      return -1;
    }
    if (date1.minute > date2.minute) {
      return 1;
    }
    if (date1.minute < date2.minute) {
      return -1;
    }
    return 0;
  }

  static int compareOnlyDay(DateTime? date1, DateTime? date2) {
    if (date1 == null && date2 == null) {
      return 0;
    }
    if (date1 == null || date2 == null) {
      return 0;
    }
    return getDateTimeStartDay(date1).difference(getDateTimeStartDay(date2)).inDays;
  }

  static String getTimeMinuteFromSecond(int second) {
    final duration = Duration(seconds: second);
    var seconds = duration.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d ');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h ');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m ');
    }
    if (seconds != 0) {
      tokens.add('${seconds}s ');
    }
    if (tokens.isEmpty) {
      tokens.add('${seconds}s ');
    }
    //xử lý nếu giá trị cuối là 0 thì bỏ đi
    //VD 1h0p thì remove 0p đi
    if (tokens.length >= 2) {
      if (tokens.last == "0s") {
        tokens.removeLast();
      }
      if (tokens.last.trim() == "0m") {
        tokens.removeLast();
      }
      if (tokens.last.trim() == "0h") {
        tokens.removeLast();
      }
      if (tokens.last.trim() == "0d") {
        tokens.removeLast();
      }
    }

    return tokens.join('');
  }

  static String getTimeMinuteFromSecondVN(int second) {
    var value = getTimeMinuteFromSecond(second);
    value = value.replaceAll("d", " ngày");
    value = value.replaceAll("h", " giờ");
    value = value.replaceAll("m", " phút");
    value = value.replaceAll("s", " giây");
    return value.trim();
  }

  static String getTimeInSecond(int second) {
    var duration = Duration(seconds: second);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 0);
  }

  static DateTime lastDayOfMonth(DateTime month) {
    final date = month.month < 12 ? DateTime.utc(month.year, month.month + 1, 1, 24) : DateTime.utc(month.year + 1, 1, 1, 24);
    return date.subtract(const Duration(days: 1));
  }

  static DateTime findFirstDateOfTheWeek(DateTime dateTime, {int offset = 1}) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
      time = "Hôm nay";
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' Ngày trước';
      } else {
        time = diff.inDays.toString() + ' Ngày trước';
      }
    } else if (diff.inDays > 365) {
      // return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
      time = "${(diff.inDays / 365).floor()} inday ${diff.inDays}";
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' Tuần trước';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' Tuần trước';
      }
    }

    return time;
  }

  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'phút';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'giờ';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'ngày';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'tuần';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'tháng';
    } else {
      timeValue = (diffInHours / (24 * 365)).round();
      timeUnit = 'năm';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? '' : '';

    return timeAgo + ' trước';
  }

  static String displayTimeAgoFromTimestampMonth(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'phút';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'giờ';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'ngày';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'tuần';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'tháng';
      return "${getDateTimeToDate(videoDate)}";
    } else {
      timeValue = (diffInHours / (24 * 365)).round();
      timeUnit = 'năm';
      return "${getDateTimeToDate(videoDate)}";
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? '' : '';

    return timeAgo + ' trước';
  }
}
