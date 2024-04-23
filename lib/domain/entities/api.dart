class API {
  final String key;
  final DateTime iat;
  final DateTime exp;

  API(this.key, this.iat, this.exp);

  API.fromAPI(API api)
      : key = api.key,
        iat = api.iat,
        exp = api.exp;

  API.fromJson(Map<String, dynamic> map)
      : key = map['key'],
        iat = DateTime.parse(map['iat']),
        exp = DateTime.parse(map['exp']);

  Map<String, dynamic> toJson() => {
        'key': key,
        'iat': iat.toIso8601String(),
        'exp': exp.toIso8601String(),
      };
}

class APIKey extends API {
  APIKey(String key, DateTime iat, DateTime exp)
      : super(key, iat, exp);

  factory APIKey.fromJson(Map<String, dynamic> map) {
    return APIKey(
      map['key'],
      DateTime.parse(map['iat']),
      DateTime.parse(map['exp']),
    );
  }
}

class RefreshAPIKey extends API {
  RefreshAPIKey(String key, DateTime iat, DateTime exp)
      : super(key, iat, exp);

  factory RefreshAPIKey.fromJson(Map<String, dynamic> map) {
    return RefreshAPIKey(
      map['key'],
      DateTime.parse(map['iat']),
      DateTime.parse(map['exp']),
    );
  }
}