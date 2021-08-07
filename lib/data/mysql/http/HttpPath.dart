class HttpPath {
  /// 基础 path —— 内网穿透。
  static const String BASE_PATH_GLOBAL = 'http://jysp.free.idcfengye.com/';

  /// 基础 path —— 仅本地。
  static const String BASE_PATH_LOCAL = 'http://localhost:8080/';

  static const String JWT = '/jwt';

  static const String NO_JWT = '/no_jwt';

  static const String LONGIN_AND_REGISTER_BY_EMAIL_SEND_EMAIL = NO_JWT + '/login_and_register_by_email/send_email';

  static const String LONGIN_AND_REGISTER_BY_EMAIL_VERIFY_EMAIL = NO_JWT + '/login_and_register_by_email/verify_email';

  /// 刷新 token。
  static const String REFRESH_TOKEN = '';
}
