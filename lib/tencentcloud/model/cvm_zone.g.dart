// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvm_zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVMZone _$CVMZoneFromJson(Map<String, dynamic> json) => CVMZone(
      json['Zone'] as String,
      json['ZoneName'] as String,
      json['ZoneId'] as String,
      json['ZoneState'] as String,
      json['ZoneType'] as String,
    );

Map<String, dynamic> _$CVMZoneToJson(CVMZone instance) => <String, dynamic>{
      'Zone': instance.zone,
      'ZoneName': instance.zoneName,
      'ZoneId': instance.zoneId,
      'ZoneState': instance.zoneState,
      'ZoneType': instance.zoneType,
    };
