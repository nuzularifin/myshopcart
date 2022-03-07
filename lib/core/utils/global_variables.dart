class GlobalVariables {
  static const bool appRelease = false;

  static const bool appDebug = true;

  static const String paramsAuthorization = "Authorization";

  static const Duration requestTime = Duration(minutes: 3);

  static const int connectTimeOutRequest = 5000;

  static const String apiKey = "721407f393e84a28593374cc2b347a98";

  static const String baseUrl = "http://api.elevenia.co.id/rest/";

  static const String baseUrlStag = "http://api.elevenia.co.id/rest/";

  //! Encryption Attribute
  static const String cyperInstance = "AES/CBC/PKCS5Padding";

  static const String secretKeyInstance = "PBKDF2WithHmacSHA1";

  static const String passwordKey = "12S_09dxfcAjKABsa";

  static const String saltKey = "LKMBx3cP8Tt37w6XF61U";

  //! Cached Prefs
  static const String cachedToken = "CACHED_TOKEN";

  static const String cachedBearerToken = "CACHED_BEARER_TOKEN";

  static const String cachedAuthToken = "CACHED_AUTH_TOKEN";
}
