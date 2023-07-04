import 'dart:convert';

import 'package:partyapp/rest_api/ApiList.dart';
import 'package:partyapp/models/paytm_model.dart';
import 'package:partyapp/models/serviceModel.dart';
import 'package:partyapp/models/services_model.dart';
import 'package:partyapp/utils/utils.dart';
import 'package:http/http.dart' as http;

class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = 'http://partyapp.v2infotech.net/api/party';

  Future<ServicesModel> service() {
    return _netUtil.get(APIS.ProductDetails).then((dynamic res) {
      return new ServicesModel.fromJson(res);
    });
  }

  Future<List<ServiceModelNew>> dakibaaServices() async {
    print("nwwwwwwwwww: running");
    final uri = Uri.parse(APIS.ProductDetails);
    print("nwwwwwwwwww: $uri");
    final response = await http.get(uri);
    print("nwwwwwwwwww: $response");
    print("nwwwwwwwwww: ${response.body}");
    final json = jsonDecode(response.body);
    print("nwwwwwwwwww: $json");
    final results = json['data'] as List<dynamic>;
    print("nwwwwwwwwww: $results");
    return results.map((e) => ServiceModelNew.fromJson(e)).toList();
  }


  Future<PaytmModel> paytm_api_call(String? orderid_paytm,String? Mode,String? txn_id,String? userid) {
    Map<String, String?> body = {
      "orderid_paytm":orderid_paytm,
      "Mode":Mode,
      "txn_id":txn_id,
      "userid":userid
    };
    return _netUtil.post(APIS.Save_ptmres, body: body, headers: {}, encoding: null).then((dynamic res) {
      return new PaytmModel.fromJson(res);
    });
  }
}