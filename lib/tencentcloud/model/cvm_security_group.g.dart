// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvm_security_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVMSecurityGroup _$CVMSecurityGroupFromJson(Map<String, dynamic> json) =>
    CVMSecurityGroup(
      json['CreatedTime'] as String,
      json['IsDefault'] as bool?,
      json['ProjectId'] as String,
      json['SecurityGroupDesc'] as String,
      json['SecurityGroupId'] as String,
      json['SecurityGroupName'] as String,
      (json['TagSet'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['UpdateTime'] as String?,
    );

Map<String, dynamic> _$CVMSecurityGroupToJson(CVMSecurityGroup instance) =>
    <String, dynamic>{
      'CreatedTime': instance.createdTime,
      'IsDefault': instance.isDefault,
      'ProjectId': instance.projectId,
      'SecurityGroupDesc': instance.securityGroupDesc,
      'SecurityGroupId': instance.securityGroupId,
      'SecurityGroupName': instance.securityGroupName,
      'TagSet': instance.tagSet,
      'UpdateTime': instance.updateTime,
    };
