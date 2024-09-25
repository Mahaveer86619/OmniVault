import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:omni_vault/common/app_constants/app_constants.dart';

Future<void> setupNotificationChannels() async {
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: notificationChannelGroupKey,
        channelKey: notificationChannelId,
        channelName: notificationChannelName,
        channelDescription: notificationChannelDescription,
        channelShowBadge: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: notificationChannelGroupKey,
        channelGroupName: notificationChannelGroupName,
      ),
    ],
  );

  bool isNotificationsEnabled =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isNotificationsEnabled) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
    debugPrint('onActionReceivedMethod');
  }
}
