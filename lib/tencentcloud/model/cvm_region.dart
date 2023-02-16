import 'package:json_annotation/json_annotation.dart';

part 'cvm_region.g.dart';

@JsonSerializable()
class CVMRegion {
  const CVMRegion(this.regionState, this.region, this.regionName);

  @JsonKey(name: "RegionState")
  final String regionState; // AVAILABLE
  @JsonKey(name: "Region")
  final String region; // ap-guangzhou
  @JsonKey(name: "RegionName")
  final String regionName; // 华南地区(广州)

  factory CVMRegion.fromJson(Map<String, dynamic> json) =>
      _$CVMRegionFromJson(json);
  Map<String, dynamic> toJson() => _$CVMRegionToJson(this);

  @override
  String toString() {
    return "$regionName $regionState";
  }
}
