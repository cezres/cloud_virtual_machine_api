import 'package:json_annotation/json_annotation.dart';

part 'cvm_instance.g.dart';

@JsonSerializable()
class CVMInstance {
  const CVMInstance(
    this.placement,
    this.instanceId,
    this.uuid,
    this.instanceState,
    this.restrictState,
    this.instanceType,
    this.cpu,
    this.memory,
    this.instanceName,
    this.instanceChargeType,
    this.osName,
    this.licenseType,
    this.stopChargingMode,
    this.publicIpAddresses,
  );

  @JsonKey(name: "Placement")
  final CVMPlacement placement;

  @JsonKey(name: "InstanceId")
  final String instanceId;
  @JsonKey(name: "Uuid")
  final String uuid;
  @JsonKey(name: "InstanceState")
  final String instanceState; // PENDING
  @JsonKey(name: "RestrictState")
  final String restrictState; // NORMAL
  @JsonKey(name: "InstanceType")
  final String instanceType; // SA2.SMALL2
  @JsonKey(name: "CPU")
  final int cpu; // 1
  @JsonKey(name: "Memory")
  final int memory; // 2
  @JsonKey(name: "InstanceName")
  final String instanceName; // 未命名
  @JsonKey(name: "InstanceChargeType")
  final String instanceChargeType; // SPOTPAID

  @JsonKey(name: "OsName")
  final String osName; // CentOS 7.9 64位
  @JsonKey(name: "LicenseType")
  final String licenseType; // TencentCloud
  @JsonKey(name: "StopChargingMode")
  final String stopChargingMode; // NOT_APPLICABLE

  @JsonKey(name: "PublicIpAddresses")
  final List<String> publicIpAddresses;

  factory CVMInstance.fromJson(Map<String, dynamic> json) =>
      _$CVMInstanceFromJson(json);
  Map<String, dynamic> toJson() => _$CVMInstanceToJson(this);

  @override
  String toString() {
    return "CVMInstance: $instanceName $osName $cpu/$memory";
  }
}

@JsonSerializable()
class CVMPlacement {
  const CVMPlacement(this.zone, this.hostId, this.projectId);

  @JsonKey(name: "Zone")
  final String zone;
  @JsonKey(name: "HostId")
  final int? hostId;
  @JsonKey(name: "ProjectId")
  final int projectId;

  factory CVMPlacement.fromJson(Map<String, dynamic> json) =>
      _$CVMPlacementFromJson(json);
  Map<String, dynamic> toJson() => _$CVMPlacementToJson(this);
}
