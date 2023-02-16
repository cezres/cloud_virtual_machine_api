import 'package:json_annotation/json_annotation.dart';

part 'cvm_image.g.dart';

@JsonSerializable()
class CVMImage {
  const CVMImage(this.imageId, this.imageSize, this.platform, this.osName,
      this.imageState);

  @JsonKey(name: "ImageId")
  final String imageId; // img-9xqekomx
  @JsonKey(name: "ImageSize")
  final int imageSize; // 20
  @JsonKey(name: "Platform")
  final String platform; // CentOS
  @JsonKey(name: "OsName")
  final String osName; // CentOS Stream 9 64位
  @JsonKey(name: "ImageState")
  final String imageState;

  factory CVMImage.fromJson(Map<String, dynamic> json) =>
      _$CVMImageFromJson(json);
  Map<String, dynamic> toJson() => _$CVMImageToJson(this);

  @override
  String toString() {
    return "CVMImage: $osName $imageId";
  }
}
