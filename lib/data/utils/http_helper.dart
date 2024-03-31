import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:rongchoi_app/data/exceptions/authentication_exception.dart';

/// A `static` helper for `HTTP` requests throughout the application.
class HttpHelper {
  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<Map<String, dynamic>> invokeHttp(dynamic url, RequestType type, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    http.Response response;
    Map<String, dynamic> responseBody;
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
    } catch (error) {
      rethrow;
    }
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `List<dynamic>`, as in a list of json objects.
  static Future<List<dynamic>> invokeHttp2(dynamic url, RequestType type, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    http.Response response;
    List<dynamic> responseBody;
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
    } on APIException {
      rethrow;
    } on SocketException {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// Invoke the `http` request, returning the [http.Response] unparsed.
  static Future<http.Response> _invoke(dynamic url, RequestType type, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    http.Response response;

    try {
      final usedEncoding = encoding ?? utf8; // Use utf8 as default encoding if encoding is null

      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url,
              headers: headers, body: body, encoding: usedEncoding);
          break;
        case RequestType.put:
          response = await http.put(url,
              headers: headers, body: body, encoding: usedEncoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }

      // Check for any errors
      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }

      return response;
    } on http.ClientException {
      // Handle any 404's
      rethrow;

      // Handle no internet connection
    } on SocketException catch(e) {
      throw Exception(e.osError?.message);
    } catch (error) {
      rethrow;
    }
  }
}

// Types used by the helper
enum RequestType { get, post, put, delete }

void main() async {
  Map<String, String> query = {
    'Authorization':
        '01b94fca0e4d7db88204f617cd5f5a77012239fbfb1f3f8e968b815bc0978f55',
  };

  try {
    // Invoke http request to login and convert body to map
    Map<String, dynamic> body = await HttpHelper.invokeHttp(
        "http://localhost:8080/v1/user", RequestType.get,
        headers: query);
    print('getUser Successful.');
  } catch (error) {
    print(error);
  }
}
