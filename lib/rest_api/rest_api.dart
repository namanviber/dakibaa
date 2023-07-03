import 'package:partyapp/ApiList.dart';
import 'package:partyapp/paytm_model.dart';
import 'package:partyapp/services_model/services_model.dart';
import 'package:partyapp/utils/utils.dart';

class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = 'http://partyapp.v2infotech.net/api/party';

  Future<ServicesModel> service() {
    return _netUtil.get(APIS.ProductDetails).then((dynamic res) {
      return new ServicesModel.fromJson(res);
    });
  }
  Future<PaytmModel> paytm_api_call(String orderid_paytm,String Mode,String txn_id,String userid) {
    Map<String, String> body = {
      "orderid_paytm":orderid_paytm,
      "Mode":Mode,
      "txn_id":txn_id,
      "userid":userid
    };
    return _netUtil.post(APIS.Save_ptmres, body: body).then((dynamic res) {
      return new PaytmModel.fromJson(res);
    });
  }
}