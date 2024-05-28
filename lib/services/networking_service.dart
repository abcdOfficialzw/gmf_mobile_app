import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/networking_response.dart';

class NetworkingService {
  Future<NetworkingResponse> makeHttpCall(
      {headers,
      required String method,
      required String url,
      required Map<String, dynamic>? body,
      BuildContext? context}) async {
    var _headers = headers ??
        {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          "Access-Control-Allow-Credentials": "true",
        };
    var request = http.Request(method, Uri.parse(url));

    log("Making Http Request");

    request.headers.addAll(_headers);
    request.body = json.encode(body);
    print(request.url);

    log("Url: ${request.url}");
    log("Headers: ${request.headers}");
    log("Body: ${request.body}");
    return await buildResponse(request);
  }

  Future<NetworkingResponse> buildResponse(request) async {
    try {
      http.StreamedResponse response = await request.send();
      //if connection to the server is successful
      String responseString = await response.stream.bytesToString();
      log("Response String: $responseString");
      log("Status code: ${response.statusCode}");
      Map<String, dynamic> data = json.decode(responseString);
      if (response.statusCode == 200) {
        print(data);

        NetworkingResponse networkingResponse =
            NetworkingResponse.fromJson(data);

        return networkingResponse;
      } else {
        Map<String, dynamic> message = json.decode(responseString);
        // ignore: unused_local_variable
        String errorKey;
        if (message["error_description"] != null) {
          errorKey = "error_description";
        } else {
          errorKey = "message";
        }
        NetworkingResponse networkingResponse =
            NetworkingResponse.fromJson(data);
        return networkingResponse;
      }
    } catch (e) {
      NetworkingResponse networkingResponse = NetworkingResponse(
          message:
              'Could not connect to the server, please check your internet connection and try again!',
          data: null,
          status: "failed",
          isException: true,
          errorMessage: e.toString());
      return networkingResponse;
    }
  }
}
