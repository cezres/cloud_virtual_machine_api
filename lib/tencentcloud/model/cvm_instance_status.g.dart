// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvm_instance_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVMInstanceStatus _$CVMInstanceStatusFromJson(Map<String, dynamic> json) =>
    CVMInstanceStatus(
      json['InstanceId'] as String,
      json['InstanceState'] as String,
    );

Map<String, dynamic> _$CVMInstanceStatusToJson(CVMInstanceStatus instance) =>
    <String, dynamic>{
      'InstanceId': instance.instanceId,
      'InstanceState': instance.instanceState,
    };
