class EnvironmentConfig {
  final String baseUrl;
  final String apiUrl;
  final String environment;

  EnvironmentConfig._({
    required this.baseUrl,
    required this.apiUrl,
    required this.environment,
  });

  // Instância singleton
  static EnvironmentConfig? _instance;

  static EnvironmentConfig get instance {
    if (_instance == null) {
      throw Exception('EnvironmentConfig não foi inicializado. Chame EnvironmentConfig.init() primeiro.');
    }
    return _instance!;
  }

  // Inicializa a configuração com base no ambiente
  static void init(String environment) {
    switch (environment) {
      case 'development':
        _instance = EnvironmentConfig._(
          baseUrl: 'https://dev.praetor.local/',
          apiUrl: 'https://dev.praetor.local/api/',
          environment: 'development',
        );
        break;
      case 'production':
        _instance = EnvironmentConfig._(
          baseUrl: 'https://barao.transoeste.com.br/',
          apiUrl: 'https://barao.transoeste.com.br/api/',
          environment: 'production',
        );
        break;
      default:
        throw Exception('Ambiente desconhecido: $environment');
    }
  }
}