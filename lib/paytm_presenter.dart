import 'package:dakibaa/models/paytm_model.dart';
import 'package:dakibaa/rest_api/rest_api.dart';

abstract class PaytmModelContract {
  void onPaytmModelSuccess(PaytmModel response);
  void onPaytmModelError(String errorTxt);
}

class PaytmModelPresenter {

  PaytmModelContract _view;
  RestDataSource api = RestDataSource();
  PaytmModelPresenter(this._view);
  getpaytm(String? orderid_paytm, Mode, txn_id, userid) {
    api.paytm_api_call(orderid_paytm, Mode, txn_id, userid).then((PaytmModel res) {
      _view.onPaytmModelSuccess(res);
    }).catchError((Object error) => _view.onPaytmModelError(error.toString()));
  }

}