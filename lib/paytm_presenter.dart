
import 'package:flutter/material.dart';
import 'package:partyapp/paytm_model.dart';
import 'package:partyapp/rest_api/rest_api.dart';
import 'package:partyapp/services_model/services_model.dart';

abstract class PaytmModelContract {
  void onPaytmModelSuccess(PaytmModel response);
  void onPaytmModelError(String errorTxt);
}

class PaytmModelPresenter {

  PaytmModelContract _view;
  RestDataSource api = new RestDataSource();
  PaytmModelPresenter(this._view);
  getpaytm(String orderid_paytm, Mode, txn_id, userid) {
    api.paytm_api_call(orderid_paytm, Mode, txn_id, userid).then((PaytmModel res) {
      _view.onPaytmModelSuccess(res);
    }).catchError((Object error) => _view.onPaytmModelError(error.toString()));
  }

}