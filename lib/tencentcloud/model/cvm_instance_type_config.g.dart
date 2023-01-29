// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvm_instance_type_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVMInstanceTypeConfig _$CVMInstanceTypeConfigFromJson(
        Map<String, dynamic> json) =>
    CVMInstanceTypeConfig(
      json['CPU'] as int,
      json['FPGA'] as int,
      json['GPU'] as int,
      json['Memory'] as int,
      json['InstanceFamily'] as String,
      json['InstanceType'] as String,
      json['Zone'] as String,
    );

Map<String, dynamic> _$CVMInstanceTypeConfigToJson(
        CVMInstanceTypeConfig instance) =>
    <String, dynamic>{
      'CPU': instance.cpu,
      'FPGA': instance.fpga,
      'GPU': instance.gpu,
      'Memory': instance.memory,
      'InstanceFamily': instance.instanceFamily,
      'InstanceType': instance.instanceType,
      'Zone': instance.zone,
    };
