class Auth {
  String? _api_key;

  String? _bearer;

  Auth.apiKey(this._api_key);

  Auth.bearer(this._api_key);

  Auth.apiKeyFromAuth(Auth auth) : _api_key = auth._api_key;

  Auth.bearerFromAuth(Auth auth) : _bearer = auth._bearer;

  Auth.apiKeyFromJson(Map<String, dynamic> map) : _api_key = map['api_key'];

  Auth.bearerFromJson(Map<String, dynamic> map) : _api_key = map['bearer'];

  /// Convert [this] to a Json `Map<String, dynamic>`. Complex structures keep their initial
  /// types.
  Map<String, dynamic> apiKeyToJson() => {
        'api_key': _api_key,
      };

  /// Convert [this] to a Json `Map<String, dynamic>`. Complex structures keep their initial
  /// types.
  Map<String, dynamic> bearerToJson() => {
        'token': _bearer,
      };
}
