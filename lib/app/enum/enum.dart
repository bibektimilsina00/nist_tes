enum AppThemeMode {
  light,
  dark,
  system;

  String toJson() => name;
  static AppThemeMode fromJson(String json) => values.byName(json);
}

enum MediaType {
  image,
  video,
  pdf,
  word,
  exel,
  ptt,
  audio,
  other;

  String toJson() => name;
  static MediaType fromJson(String json) => values.byName(json);
}
