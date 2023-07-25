import 'package:json_annotation/json_annotation.dart';
part 'services_model.g.dart';

@JsonSerializable()
class ServicesModel {

  ServicesModel(this.status,this.message,this.servicesModel_list);
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  List<ServicesModel_list>? servicesModel_list;
  factory ServicesModel.fromJson(Map<String, dynamic> json) => _$ServicesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesModelToJson(this);
}

@JsonSerializable()
class ServicesModel_list {

  ServicesModel_list(this.id,this.productname,this.product_descr,this.rate15,this.rate30,this.rate50,this.rate75,this.rate100);
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'productname')
  final String?  productname;
  @JsonKey(name: 'product_descr')
  final String?  product_descr;
  @JsonKey(name: 'rate15')
  final int?  rate15;
  @JsonKey(name: 'rate30')
  final int?  rate30;
  @JsonKey(name: 'rate50')
  final int?  rate50;
  @JsonKey(name: 'rate75')
  final int?  rate75;
  @JsonKey(name: 'rate100')
  final int?  rate100;

  factory ServicesModel_list.fromJson(Map<String, dynamic> json) => _$ServicesModel_listFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesModel_listToJson(this);
}