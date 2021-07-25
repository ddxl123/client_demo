class ParseIntoSqls {
  Map<String, String> parseIntoSqls = <String, String>{
  'user': 'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER)',
  'user_info': 'CREATE TABLE user_info (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,user_aiid INTEGER)',
  'app_version_info': 'CREATE TABLE app_version_info (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,saved_version TEXT)'
};
}
