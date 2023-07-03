class ServiceModelNew {
  String? status;
  String? message;
  List<Data>? data;

  ServiceModelNew({this.status, this.message, this.data});

  ServiceModelNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? productname;
  String? productDescr;
  int? rate15;
  int? rate30;
  int? rate50;
  int? rate75;
  int? rate100;
  bool? isactive;
  String? imagename;

  Data(
      {this.id,
        this.productname,
        this.productDescr,
        this.rate15,
        this.rate30,
        this.rate50,
        this.rate75,
        this.rate100,
        this.isactive,
        this.imagename});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productname = json['productname'];
    productDescr = json['product_descr'];
    rate15 = json['rate15'];
    rate30 = json['rate30'];
    rate50 = json['rate50'];
    rate75 = json['rate75'];
    rate100 = json['rate100'];
    isactive = json['isactive'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productname'] = this.productname;
    data['product_descr'] = this.productDescr;
    data['rate15'] = this.rate15;
    data['rate30'] = this.rate30;
    data['rate50'] = this.rate50;
    data['rate75'] = this.rate75;
    data['rate100'] = this.rate100;
    data['isactive'] = this.isactive;
    data['imagename'] = this.imagename;
    return data;
  }
}
