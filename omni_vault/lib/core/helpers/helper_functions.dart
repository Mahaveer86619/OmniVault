import 'package:intl/intl.dart';

Duration getDurationBetween(String startTime, String endTime) {
  // Parse the strings into DateTime objects
  final startDateTime = DateTime.parse(startTime);
  final endDateTime = DateTime.parse(endTime);

  // Calculate the difference
  final difference = endDateTime.difference(startDateTime);

  // Extract hours and minutes
  final hours = difference.inHours;
  final minutes = difference.inMinutes % 60;

  return Duration(hours: hours, minutes: minutes);
}

String formatString(String string, int maxLength) {
  if (string.length > maxLength) {
    return '${string.substring(0, maxLength)}...';
  }
  return string;
}

String formatDate(String iso8601String) {
  final DateTime dateTime = DateTime.parse(iso8601String);
  return DateFormat('d MMMM, yyyy').format(dateTime);
}