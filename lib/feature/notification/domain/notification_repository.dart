

abstract class NotificationRepository {
  Future<List<Map<String,dynamic>>> getNotifications();
  Future<Map<String,dynamic>> getNotification(String id);
  Future<String> deleteNotification(String id);
}