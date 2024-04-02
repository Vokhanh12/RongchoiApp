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

   Uri url = Uri.parse("http://10.0.2.2:8080/v1/login");

  Map<String, String> query = {
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImJhNjI1OTZmNTJmNTJlZDQ0MDQ5Mzk2YmU3ZGYzNGQyYzY0ZjQ1M2UiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcm9uZ2Nob2ktZTk2OTAiLCJhdWQiOiJyb25nY2hvaS1lOTY5MCIsImF1dGhfdGltZSI6MTcxMjA2NDA2NiwidXNlcl9pZCI6IlZabjY2T3BFa2pNeXprSFNUbzJCcUNQWlU3RjMiLCJzdWIiOiJWWm42Nk9wRWtqTXl6a0hTVG8yQnFDUFpVN0YzIiwiaWF0IjoxNzEyMDY0MDY2LCJleHAiOjE3MTIwNjc2NjYsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsidGVzdEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.F3ypgu83NMkEJtmqzCYPGsTbHBw60YgV0LPe0j2dBaOPAP_yICtMCQuqRyoQQjO8sjbwninteeflEG_RGEvNUl9RVMz0kJ-FsNC12K90V9ObqM0gvhJHh1jeJ9lWz3KSjjSRrFIYZypawNbqErSOR77ArYTru5ubq3ynoJKmOiuugQVsT_HAIoXHFVioJR0xciaf1lLk-Tx2Kx5qVP1Haw9avCTOJ5ro8QyDtSMoA9QZ0gFqMeCzk2iP9GGUfrrjrPqLtd9GqoPdF9AxNzjUCgGrxMGjvwksICkgBVWXuJkYyqOhQC_4tzejvR4ZPkXwRchf902oDG54OKUDntWZJA',
  };

  try {
    // Invoke http request to login and convert body to map
    Map<String, dynamic> body = await HttpHelper.invokeHttp(
        url, RequestType.get,
        headers: query);
    print('getUser Successful.');
  } catch (error) {
    print(error);
  }
}
