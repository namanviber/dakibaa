class ServiceModelNew {
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

  ServiceModelNew(
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

  ServiceModelNew.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['productname'] = productname;
    data['product_descr'] = productDescr;
    data['rate15'] = rate15;
    data['rate30'] = rate30;
    data['rate50'] = rate50;
    data['rate75'] = rate75;
    data['rate100'] = rate100;
    data['isactive'] = isactive;
    data['imagename'] = imagename;
    return data;
  }
}