class ParseIntoSqls {
  Map<String, String> parseIntoSqls = <String, String>{
  'app_version_info': 'CREATE TABLE app_version_info (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,saved_version TEXT)',
  'upload': 'CREATE TABLE upload (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,for_table_name TEXT,for_row_id INTEGER,for_aiid INTEGER,updated_columns TEXT,curd_status INTEGER,upload_status INTEGER,mark INTEGER)',
  'user': 'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER)',
  'f_complete': 'CREATE TABLE f_complete (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,title TEXT)',
  'f_fragment': 'CREATE TABLE f_fragment (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,title TEXT)',
  'f_memory': 'CREATE TABLE f_memory (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,title TEXT)',
  'f_rule': 'CREATE TABLE f_rule (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,title TEXT)',
  'pn_complete': 'CREATE TABLE pn_complete (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,easy_position TEXT,title TEXT)',
  'pn_fragment': 'CREATE TABLE pn_fragment (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,used_rule_aiid INTEGER,easy_position TEXT,title TEXT)',
  'pn_memory': 'CREATE TABLE pn_memory (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,easy_position TEXT,title TEXT)',
  'pn_rule': 'CREATE TABLE pn_rule (id INTEGER PRIMARY KEY AUTOINCREMENT,aiid INTEGER,uuid TEXT,created_at INTEGER,updated_at INTEGER,easy_position TEXT,title TEXT)'
};
}
