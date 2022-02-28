import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiUrl = 'https://app.cora.ro:9444/cora-api-gateway/';

const headers = {
  "Cache-Control": "no-cache",
  "Accept": "application/json",
  "Content-Type": "application/json",
  "authorization": "Bearer tgozgk9m2vucfcph29nf9ny59a7qro6a",
  "email": "iulia.neacsu@yahoo.com",
  "uniqueId": "",
  "username": "aXVsaWEubmVhY3N1QHlhaG9vLmNvbQ==",
  "password": "Q29yYTEyMzQh",
  "fcmTokenId":
  "fynjGlu_Rt2EMYR7HX1gmT:APA91bHfwm-v352BfKpi5X3DT7Vzoa3tcZTtTgjaBzrFmYcyHqf6yLIPidSZV-u2lNKIZIkb_64HfDo4-PPRBa-euCuOCkQe27n2chQ7jeN0yis7YR4WRV4t0CXKrNKlBn6iazSLHw4Y",
  "storeId": "8",
  "fideliaId": "676694",
  "deviceId": "747736CC-6FAA-47FD-9AB0-EA6BCB91E94D",
  "deviceOS": "iOS v15.0",
  "deviceType": "Apple iPhone",
  "appVersion": "2.5.16",
};
var token;

Future<Object> postRequest(var api, var body) async {
  print('Send request: ${api} with body ${body}');
  var response = await http
      .post(
    Uri.parse('${apiUrl}${api}'),
    body: body,
    headers: headers,
  )
      .timeout(const Duration(
    milliseconds: 50000,
  ));
  print("RESPONSE STATUS: ${response.statusCode}");

  if (response.statusCode == 200) {
    var jsonString = response.body;
    print("RESPONSE BODY: ${jsonDecode(jsonString)}");
    return jsonString;
  } else {
    throw Exception('error');
  }
}

Future getProductDetails(var ean) async {
  var body = jsonEncode(<String, String>{
    "ean": "${ean}",
  });
  var response =
  await postRequest("mobile/selfScanning/getProductDetails", body);
  print(response);
  return response;
}

Future getBasket() async {
  var body = jsonEncode(<String, String>{
    "clientId": "676694",
    "storeId": "8",
    "cardNumber": "9992040888346"
  });
  var response = await postRequest("mobile/getBasket", body);
  token = jsonDecode(response.toString())["transactionSuccess"]["token"];
  return response;
}

addSelfScanningProduct(eanCode, quantity) {
  var body = jsonEncode(<String, String>{
    "token": "${token}",
    "eanCode": "${eanCode}",
    "quantity": "${quantity}"
  });
  postRequest("mobile/addProduct", body);
}

updateSelfScanningProduct(eanCode, quantity) {
  var body = jsonEncode(<String, String>{
    "token": "${token}",
    "eanCode": "${eanCode}",
    "quantity": "${quantity}"
  });
  postRequest("mobile/updateProduct", body);
}

clearSelfScanningBasket() {
  var body = jsonEncode(<String, String>{
    "token": "${token}",
  });
  postRequest("mobile/clearBasket", body);
}

finalizeSelfScanningBasket() {
  var body = jsonEncode(<String, String>{
    "token": "${token}",
  });
  postRequest("mobile/finalizeBasket", body);
}

Future getPreviewBenefits(double subtotal, List items) async {
  var body = jsonEncode(<String, Object>{
    "card": "9992040888346",
    "items": items,
    "store": "8",
    "subtotal": double.parse(subtotal.toStringAsFixed(2)),
  });
  var response = await postRequest("mobile/previewBenefits", body);
  print(response);
  return response;
}
