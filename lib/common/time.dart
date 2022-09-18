class DateTimeBeautifier {
  final DateTime dateTime;

  DateTimeBeautifier(this.dateTime);

  String get hourMinute {
    var hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    var minute = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();
    var second = dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second.toString();
    return '$hour:$minute';
  }

  String get hourMinuteSecond {
    var hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    var minute = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();
    var second = dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second.toString();
    return '$hour:$minute:$second';
  }

  String get shortDateTime {
    var month = dateTime.month < 10 ? '0${dateTime.month}' : dateTime.month;
    var day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day;

    var hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    var minute = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();

    return '$month-$day $hour:$minute';
  }

  String get longDateTime {
    var month = dateTime.month < 10 ? '0${dateTime.month}' : dateTime.month;
    var day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day;

    var hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    var minute = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();
    var second = dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second.toString();

    return '${dateTime.year}-$month-$day $hour:$minute:$second';
  }

  String get longDate {
    var month = dateTime.month < 10 ? '0${dateTime.month}' : dateTime.month;
    var day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day;

    return '${dateTime.year}-$month-$day';
  }

  String format(String format) {
    var month = dateTime.month < 10 ? '0${dateTime.month}' : dateTime.month;
    var day = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day;

    var hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    var minute = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();
    var second = dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second.toString();

    String target = format.replaceAll('%Y', dateTime.year.toString());
    target = target.replaceFirst('%M', month.toString());
    target = target.replaceFirst('%D', day.toString());

    target = target.replaceFirst('%h', hour.toString());
    target = target.replaceFirst('%m', minute.toString());
    target = target.replaceFirst('%s', second.toString());

    return target;
  }
}
