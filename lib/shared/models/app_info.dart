class AppInfo {
  const AppInfo({
    required this.name,
    required this.version,
    required this.environment,
  });

  final String name;
  final String version;
  final String environment;

  factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(
    name: json['name'] as String,
    version: json['version'] as String,
    environment: json['environment'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'version': version,
    'environment': environment,
  };
}
