// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvm_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVMInstance _$CVMInstanceFromJson(Map<String, dynamic> json) => CVMInstance(
      CVMPlacement.fromJson(json['Placement'] as Map<String, dynamic>),
      json['InstanceId'] as String,
      json['Uuid'] as String,
      json['InstanceState'] as String,
      json['RestrictState'] as String,
      json['InstanceType'] as String,
      json['CPU'] as int,
      json['Memory'] as int,
      json['InstanceName'] as String,
      json['InstanceChargeType'] as String,
      json['OsName'] as String,
      json['LicenseType'] as String,
      json['StopChargingMode'] as String,
      (json['PublicIpAddresses'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CVMInstanceToJson(CVMInstance instance) =>
    <String, dynamic>{
      'Placement': instance.placement,
      'InstanceId': instance.instanceId,
      'Uuid': instance.uuid,
      'InstanceState': instance.instanceState,
      'RestrictState': instance.restrictState,
      'InstanceType': instance.instanceType,
      'CPU': instance.cpu,
      'Memory': instance.memory,
      'InstanceName': instance.instanceName,
      'InstanceChargeType': instance.instanceChargeType,
      'OsName': instance.osName,
      'LicenseType': instance.licenseType,
      'StopChargingMode': instance.stopChargingMode,
      'PublicIpAddresses': instance.publicIpAddresses,
    };

CVMPlacement _$CVMPlacementFromJson(Map<String, dynamic> json) => CVMPlacement(
      json['Zone'] as String,
      json['HostId'] as int?,
      json['ProjectId'] as int,
    );

Map<String, dynamic> _$CVMPlacementToJson(CVMPlacement instance) =>
    <String, dynamic>{
      'Zone': instance.zone,
      'HostId': instance.hostId,
      'ProjectId': instance.projectId,
    };
