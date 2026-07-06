enum Environment { dev, staging, prod }

extension EnvironmentX on Environment {
  String get envFileName => switch (this) {
    Environment.dev => '.env.dev',
    Environment.staging => '.env.staging',
    Environment.prod => '.env.prod',
  };

  String get label => name;
}
