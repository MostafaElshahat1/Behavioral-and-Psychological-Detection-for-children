// core/networking/api_constanse.dart
class ApiConstanse {
  static const String apiBaseUrl = 'https://orientonline.info/api/';
  static const String getProducts = "products";
  static const String getCategories= "categories";
  static const String favorites= "favorites";
  static const String getCategoriesById= "categories/{id}";
  static const String login = "auth/login";
  static const String signup = "auth/register";
  static const String spesialization = "specialization/index";
}

//https://vcare.integration25.com/api
class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbeddenError = "forbeddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflectError = "conflectError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String couchError = "couchError";
  static const String noInternalError = "noInternalError";
  static const String lodingMessage = "loding_Message";
  static const String retryAgainMessage = "retry_Again_Message";
  static const String ok = "Ok";
}
