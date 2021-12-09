import 'package:blueberry/utils/logger.dart';
import 'package:flutter/material.dart';

class DateFormatter {
  static String dateForrmatter(DateTime createdDate) {
    DateTime now = DateTime.now().toUtc();
    Duration formattedDate = now.difference(createdDate);
    if (formattedDate.inMinutes < 6) {
      return '방금 전';
    } else if (formattedDate.inMinutes < 60 && formattedDate.inMinutes > 5) {
      return '${formattedDate.inMinutes}분 전';
    } else if (formattedDate.inMinutes > 59 && formattedDate.inMinutes < 1440) {
      return '${formattedDate.inHours}시간 전';
    } else if (formattedDate.inMinutes > 1439 &&
        formattedDate.inMinutes < 43200) {
      return '${formattedDate.inDays}일 전';
    } else {
      DateTime check = DateUtils.dateOnly(createdDate);
      final year = check.year.toString();
      final month = check.month.toString();
      final day = check.day.toString();

      return '${year}-${month}-${day}';
    }
  }
}
