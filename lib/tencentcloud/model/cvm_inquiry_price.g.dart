// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvm_inquiry_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVMInquiryPrice _$CVMInquiryPriceFromJson(Map<String, dynamic> json) =>
    CVMInquiryPrice(
      CVMInstancePrice.fromJson(json['BandwidthPrice'] as Map<String, dynamic>),
      CVMInstancePrice.fromJson(json['InstancePrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CVMInquiryPriceToJson(CVMInquiryPrice instance) =>
    <String, dynamic>{
      'BandwidthPrice': instance.bandwidthPrice,
      'InstancePrice': instance.instancePrice,
    };

CVMInstancePrice _$CVMInstancePriceFromJson(Map<String, dynamic> json) =>
    CVMInstancePrice(
      json['ChargeUnit'] as String,
      (json['Discount'] as num).toDouble(),
      (json['UnitPrice'] as num).toDouble(),
      (json['UnitPriceDiscount'] as num).toDouble(),
    );

Map<String, dynamic> _$CVMInstancePriceToJson(CVMInstancePrice instance) =>
    <String, dynamic>{
      'ChargeUnit': instance.chargeUnit,
      'Discount': instance.discount,
      'UnitPrice': instance.unitPrice,
      'UnitPriceDiscount': instance.unitPriceDiscount,
    };
