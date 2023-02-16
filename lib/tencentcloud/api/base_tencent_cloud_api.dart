import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseTencentCloudApi {
  BaseTencentCloudApi(
      {required this.secretId, required this.secretKey, required this.service});

  final String secretId;
  final String secretKey;
  final String service; // cvm
  bool isDebug = false;

  final Dio _dio = Dio();

  Future<List<T>> requestResults<T>(
      {required String action,
      required String region,
      Map<String, dynamic> params = const {},
      required String decodeKey,
      required T Function(Map<String, dynamic>) decoder}) async {
    final response =
        await sendReeust(action: action, region: region, params: params);
    return (response.data["Response"][decodeKey] as List)
        .map((e) => decoder(e))
        .toList();
  }

  Future<T> requestResult<T>(
      {required String action,
      required String region,
      Map<String, dynamic> params = const {},
      required String decodeKey,
      required T Function(Map<String, dynamic>) decoder}) async {
    final response =
        await sendReeust(action: action, region: region, params: params);
    return decoder(response.data["Response"][decodeKey]);
  }

  String buildAuthorization(
      {required String secretId,
      required String secretKey,
      required String payload,
      required Map<String, String> headers,
      required String requestTimestamp,
      required String date}) {
    buildCanonicalHeaders() {
      List<String> items = [];
      headers.forEach((key, value) {
        items.add("${key.toLowerCase()}:${value.toLowerCase()}\n");
      });
      items.sort();
      return items.join();
    }

    buildSignedHeaders() {
      List<String> items = [];
      headers.forEach((key, value) {
        items.add(key.toLowerCase());
      });
      items.sort();
      return items.join(";");
    }

    buildHashedRequestPayload() {
      var bytes = utf8.encode(payload);
      var digest = sha256.convert(bytes);
      return digest.toString().toLowerCase();
    }

    const httpRequestMethod = "POST";
    const canonicalURI = "/";
    const canonicalQueryString = "";
    final canonicalHeaders = buildCanonicalHeaders();
    final signedHeaders = buildSignedHeaders();
    final hashedRequestPayload = buildHashedRequestPayload();
    final canonicalRequest =
        '$httpRequestMethod\n$canonicalURI\n$canonicalQueryString\n$canonicalHeaders\n$signedHeaders\n$hashedRequestPayload';

    const algorithm = "TC3-HMAC-SHA256";
    final credentialScope = "$date/$service/tc3_request";
    final hashedCanonicalRequest = () {
      var bytes = utf8.encode(canonicalRequest);
      var digest = sha256.convert(bytes);
      return digest.toString().toLowerCase();
    }();

    final stringToSign =
        '$algorithm\n$requestTimestamp\n$credentialScope\n$hashedCanonicalRequest';

    var key = utf8.encode("TC3$secretKey");

    var secretDate = Hmac(sha256, key).convert(utf8.encode(date)).bytes;
    var secretService =
        Hmac(sha256, secretDate).convert(utf8.encode(service)).bytes;
    var secretSigning =
        Hmac(sha256, secretService).convert(utf8.encode("tc3_request")).bytes;

    var signature = Hmac(sha256, secretSigning)
        .convert(utf8.encode(stringToSign))
        .toString()
        .toLowerCase();

    var authorization =
        '$algorithm Credential=$secretId/$credentialScope, SignedHeaders=$signedHeaders, Signature=$signature';

    return authorization;
  }

  Future<Response<dynamic>> sendReeust(
      {required String action,
      required String region,
      String version = "2017-03-12",
      Map<String, dynamic> params = const {}}) async {
    buildRequestTimestamp(DateTime dateTime) {
      final time = (dateTime.millisecondsSinceEpoch / 1000);
      return time.toInt().toString();
    }

    buildDate(DateTime dateTime) {
      var result = "${dateTime.year}";
      if (dateTime.month >= 10) {
        result += "-${dateTime.month}";
      } else {
        result += "-0${dateTime.month}";
      }
      if (dateTime.day >= 10) {
        result += "-${dateTime.day}";
      } else {
        result += "-0${dateTime.day}";
      }
      return result;
    }

    final dateTime = DateTime.now().toUtc();
    final timestamp = buildRequestTimestamp(dateTime);
    final date = buildDate(dateTime);

    Map<String, dynamic> newParams = {};
    for (var key in params.keys) {
      if (params[key] != null) {
        newParams[key] = params[key];
      }
    }
    final payload = json.encode(newParams);

    var header = {
      "Host": "$service.tencentcloudapi.com",
      "Content-Type": "application/json",
    };

    final authorization = buildAuthorization(
        secretId: secretId,
        secretKey: secretKey,
        payload: payload,
        headers: header,
        requestTimestamp: timestamp,
        date: date);

    header["X-TC-Action"] = action;
    header["X-TC-Region"] = region;
    header["X-TC-Timestamp"] = timestamp;
    header["X-TC-Version"] = version;
    header["Authorization"] = authorization;
    header["X-TC-Language"] = "zh-CN";

    try {
      final response = await _dio.post("https://$service.tencentcloudapi.com",
          data: payload, options: Options(headers: header, method: "POST"));

      if (isDebug) {
        debugPrint("Request Action: $action");
        if (newParams.isNotEmpty) {
          debugPrint("Payload: $newParams");
        }
        debugPrint("Response: ${json.encode(response.data)}");
      }

      if (response.data["Response"]["Error"] != null) {
        throw response.data["Response"]["Error"]["Message"];
      }
      return response;
    } catch (e) {
      if (isDebug) {
        debugPrint("Error: $e");
      }
      rethrow;
    }
  }
}
