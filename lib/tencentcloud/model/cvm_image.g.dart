// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cvm_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVMImage _$CVMImageFromJson(Map<String, dynamic> json) => CVMImage(
      json['ImageId'] as String,
      json['ImageSize'] as int,
      json['Platform'] as String,
      json['OsName'] as String,
      json['ImageState'] as String,
    );

Map<String, dynamic> _$CVMImageToJson(CVMImage instance) => <String, dynamic>{
      'ImageId': instance.imageId,
      'ImageSize': instance.imageSize,
      'Platform': instance.platform,
      'OsName': instance.osName,
      'ImageState': instance.imageState,
    };
