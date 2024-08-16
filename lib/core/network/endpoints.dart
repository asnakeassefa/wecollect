class Endpoints {
  static String baseUrl = "https://cleanvillage-d9fyh8hwe0arftbc.southafricanorth-01.azurewebsites.net";
  static String login = "$baseUrl/";
  static String user = "$baseUrl/user";
  static String signup = "$baseUrl/register";
  static String refresh = "$baseUrl/token-refresh/";
  static String request = "$baseUrl/api/wasteplasticrequestor/create/";
  static String dashboard = "$baseUrl/api/wasteplasticrequestor/history";
  static String recentActivity = "$baseUrl/api/wasteplasticrequestor/latest";
  static String pickRequest = "$baseUrl/api/wasteplasticrequestor/requestpickup/create";
  static String agentRequest = "$baseUrl/api/taskassigned";
  static String content = "$baseUrl/api/contentManagement";
  static String wasteType = "$baseUrl/api/wastePlasticType";
  static String acceptRequest = '$baseUrl/api/wasteplasticrequestor/requestpickup/update';
  static String completeRequest = '$baseUrl/api/taskassigned/update';
}
