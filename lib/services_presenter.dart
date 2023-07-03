import 'package:partyapp/rest_api/rest_api.dart';
import 'package:partyapp/services_model/services_model.dart';

abstract class ServicesModelContract {
  void onServicesModelSuccess(ServicesModel response);
  void onServicesModelError(String errorTxt);
}

class ServicesModelPresenter {

  ServicesModelContract _view;
  RestDataSource api = new RestDataSource();
  ServicesModelPresenter(this._view);

  getServices() {
    api.service().then((ServicesModel res) {
      _view.onServicesModelSuccess(res);
    }).catchError((Object error) => _view.onServicesModelError(error.toString()));
  }
}