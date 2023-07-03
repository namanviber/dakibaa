import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'paytm_model.g.dart';

@JsonSerializable()
class PaytmModel {

  PaytmModel(this.status,this.message);
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'message')
  final String message;

  factory PaytmModel.fromJson(Map<String, dynamic> json) => _$PaytmModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaytmModelToJson(this);
}