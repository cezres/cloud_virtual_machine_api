import 'package:json_annotation/json_annotation.dart';

part 'cvm_inquiry_price.g.dart';

@JsonSerializable()
class CVMInquiryPrice {
  const CVMInquiryPrice(this.bandwidthPrice, this.instancePrice);

  @JsonKey(name: "BandwidthPrice")
  final CVMInstancePrice bandwidthPrice;
  @JsonKey(name: "InstancePrice")
  final CVMInstancePrice instancePrice;

  factory CVMInquiryPrice.fromJson(Map<String, dynamic> json) =>
      _$CVMInquiryPriceFromJson(json);
  Map<String, dynamic> toJson() => _$CVMInquiryPriceToJson(this);
}

@JsonSerializable()
class CVMInstancePrice {
  const CVMInstancePrice(
      this.chargeUnit, this.discount, this.unitPrice, this.unitPriceDiscount);

  @JsonKey(name: "ChargeUnit")
  final String chargeUnit;
  @JsonKey(name: "Discount")
  final double discount;
  @JsonKey(name: "UnitPrice")
  final double unitPrice;
  @JsonKey(name: "UnitPriceDiscount")
  final double unitPriceDiscount;

  factory CVMInstancePrice.fromJson(Map<String, dynamic> json) =>
      _$CVMInstancePriceFromJson(json);
  Map<String, dynamic> toJson() => _$CVMInstancePriceToJson(this);
}
