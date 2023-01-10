import 'dart:convert';

import './globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

getToken() async {
  String url = globals.baseurl + "/mock?id=" + globals.callId.toString();
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlFUaERPVGc1TXpkQ1FUbENRVGd6TVRsRU1URTFOVFl3TVRrM1JUTkdRall6TWtNME1qSkZPUSJ9.eyJodHRwczovL3Jhdy1sYWJzLmNvbS9wZXJtaXNzaW9ucyI6W3siZGV2LThvYzk4MGg1M2wwNDFoNCI6eyJjb25zdW1lciI6WyIiXSwicHJvZHVjZXIiOlsiYWRtaW4iXX19XSwiaXNzIjoiaHR0cHM6Ly9yYXcuZXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDYzYmJmZDNkYjI5YTkzNTNjYmQ2YjI1YiIsImF1ZCI6WyJodHRwczovL3Jhdy1sYWJzLmNvbS9yYXcvYWRtaW4iLCJodHRwczovL3Jhdy5ldS5hdXRoMC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNjczMjY0NDQ4LCJleHAiOjE2NzMzNTA4NDgsImF6cCI6IkdPTFVIM05VM1dtY2R5T2tVekVCNHAwZ2FmN2N2NkhaIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCIsInBlcm1pc3Npb25zIjpbXX0.IgyOstmkkeFSEToQaufVlCQzZMKpawlg2Iicf33ozhagqJc3bO59s3t4Xfsraynxopyy6BSuTDNfPZCSgcDp6vyfzCQ_wW1IZG4QQlkoquS_gQ7UkbimKFDcTPHWNRgAvBrp2M0apIv4a3fxGVYJwYHg7LQfbL054U9VQeGkCsVukWUf480bWSGNCUS4fpRWUEVvNpkOBi-qD_pf9icNKxOM2Q1XPe2C85Z3pQY-VeBj5p9DbJFJ-VpW3di5K3noPWjmvuNpOLg940P-8yIBXtaD-vlC1pZZ_6E-Jf3WxW2ZwFcgIiUrczM4TOPj7FKwwh7lvVbJ_LaW36kX75CKoA',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> tokenData = jsonDecode(response.body);
    globals.token = tokenData['token'];
    print(globals.token);
  } else {
    throw Exception('Failed to load token');
  }
}

setUrl() {
  globals.callServerUrl = "wss://rajeevwebrtc.livekit.cloud";
}
