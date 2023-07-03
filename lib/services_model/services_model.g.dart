// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) {
  return ServicesModel(
      json['status'],
      json['message'],
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : ServicesModel_list.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.servicesModel_list
    };

ServicesModel_list _$ServicesModel_listFromJson(Map<String, dynamic> json) {
  return ServicesModel_list(
      json['id'] as int,
      json['productname'],
      json['product_descr'],
      json['rate15'] as int,
      json['rate30'] as int,
      json['rate50'] as int,
      json['rate75'] as int,
      json['rate100'] as int);
}

Map<String, dynamic> _$ServicesModel_listToJson(ServicesModel_list instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productname': instance.productname,
      'product_descr': instance.product_descr,
      'rate15': instance.rate15,
      'rate30': instance.rate30,
      'rate50': instance.rate50,
      'rate75': instance.rate75,
      'rate100': instance.rate100
    };
