import 'package:efood/utils/notifiers/config_notifier.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateConverter._() {
  static String formatDate({required DateTime dateTime, bool isSecond = true}) {
    if (isSecond) {
      DateFormat('yyyy-MM-dd ${_timeFormatter()}:ss').format(dateTime);
    }
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static String dateToTimeOnly({required DateTime dateTime}) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
  }

  static String localDateToIsoStringAMPM({required DateTime dateTime}) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime({required String time}) {
    return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parse(time));
  }

  static bool isAvailable({required String start, required String end, DateTime? time}) {
    DateTime currentTime;

    if (time != null) {
      currentTime = time;
    } else {
      currentTime = DateTime.now();
    }
    DateTime startValue = DateFormat('hh:mm:ss').parse(start);
    DateTime endValue = DateFormat('hh:mm:ss').parse(end);
    DateTime startTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      startValue.hour,
      startValue.minute,
      startValue.second,
    );
    DateTime endTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      endValue.hour,
      endValue.minute,
      endValue.second,
    );
    if (endTime.isBefore(startTime)) {
      endTime = endTime.add(Duration(days: 1));
    }
    return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
  }

  static String convertTimeRange(String start, String end) {
    DateTime startTime = DateFormat('HH:mm:ss').parse(start);
    DateTime endTime = DateFormat('HH:mm:ss').parse(end);
    return '${DateFormat('hh:mm aa').format(startTime)} - ${DateFormat('hh:mm aa').format(endTime)}';
  }

  static DateTime stringTimeToDateTime(String time) {
    return DateFormat('HH:mm:ss').parse(time);
  }

  static String deliveryDateAndTimeToDate({required String deliveryDate, required String deliveryTime}) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(deliveryDate);
    DateTime time = DateFormat('HH:mm').parse(deliveryTime);
    return '${DateFormat('dd-MMM-yyyy').format(date)} ${DateFormat(_timeFormatter()).format(time)}';
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static String convertToWeekNameAndTime(DateTime date) {
    return DateFormat('EEEE  hh:mm aa').format(date);
  }

  static String _timeFormatter() {
    final configNotifier = Get.find<ConfigNotifier>();

    return configNotifier.config.value?.timeFormat == '24' ? 'HH:mm' : 'hh:mm a';
  }

  static String getWeekName(String index) {
    late String weekName;
    switch (index) {
      case '0':
        weekName = 'Sunday';
        break;
      case '1':
        weekName = 'Monday';
        break;
      case '2':
        weekName = 'Tuesday';
        break;
      case '3':
        weekName = 'Wednesday';
        break;
      case '4':
        weekName = 'Thursday';
        break;
      case '5':
        weekName = 'Friday';
        break;
      case '6':
        weekName = 'Saturday';
        break;
    }
    return weekName;
  }
}
