class ForeignKeyCreator {
  ForeignKeyCreator(this.tableName, this.isDeleteFollowForeignKey);

  /// 外键对应的表名。
  String tableName;

  /// 当外键对应的外表 row 被删除时，是否同时删除当前 row。
  bool isDeleteFollowForeignKey;

  /// 是 two 还是 single
  bool isTwo = false;
}
