import 'package:flutter/material.dart';

class ProductServicesModel{

  var prod_id;
  var total;
  int? qyt;

  ProductServicesModel(this.prod_id, this.total,this.qyt);

  Map<String, dynamic> toJson() => {
    'prod_id': prod_id,
    'total': total,
    'qty': qyt,
  };
}