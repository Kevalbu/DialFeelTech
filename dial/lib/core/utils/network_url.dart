class NetworkUrl {
  static const String baseUrl = 'https://quikx-crm-api.teamfeeltech.com';
  static const String loginUrl = '$baseUrl/api/v1/Authentication/login';
  static const String addListNameUrl = '$baseUrl/api/v1/List';
  static const String getListNameUrl = '$baseUrl/api/v1/List?Option=true';
  static const String addContactUrl = '$baseUrl/api/v1/Contact';
  static const String deleteListUrl = '$baseUrl/api/v1/List/';
  static const String emptyListUrl = '$baseUrl/api/v1/List/empty-list/';
  static const String getContactNameUrl = '$baseUrl/api/v1/Contact';
  static const String rechurnListUrl = '$baseUrl/api/v1/Contact/rechurn-list';
  static const String oneContactUrl = '$baseUrl/api/v1/Contact/dial/';
}
