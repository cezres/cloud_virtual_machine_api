import 'package:json_annotation/json_annotation.dart';

part 'cvm_zone.g.dart';

@JsonSerializable()
class CVMZone {
  const CVMZone(
      this.zone, this.zoneName, this.zoneId, this.zoneState, this.zoneType);

  @JsonKey(name: "Zone")
  final String zone; // ap-hongkong-1
  @JsonKey(name: "ZoneName")
  final String zoneName; // 香港一区
  @JsonKey(name: "ZoneId")
  final String zoneId; // 300001
  @JsonKey(name: "ZoneState")
  final String zoneState; // UNAVAILABLE / AVAILABLE
  @JsonKey(name: "ZoneType")
  final String zoneType; // availability-zone

  factory CVMZone.fromJson(Map<String, dynamic> json) =>
      _$CVMZoneFromJson(json);
  Map<String, dynamic> toJson() => _$CVMZoneToJson(this);

  @override
  String toString() {
    return "CVMZone: $zoneName $zoneState";
  }
}
