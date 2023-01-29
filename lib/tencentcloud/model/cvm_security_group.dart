import 'package:json_annotation/json_annotation.dart';

part 'cvm_security_group.g.dart';

@JsonSerializable()
class CVMSecurityGroup {
  const CVMSecurityGroup(
      this.createdTime,
      this.isDefault,
      this.projectId,
      this.securityGroupDesc,
      this.securityGroupId,
      this.securityGroupName,
      this.tagSet,
      this.updateTime);

  @JsonKey(name: "CreatedTime")
  final String createdTime; // 2022-05-25 14:12:29
  @JsonKey(name: "IsDefault")
  final bool? isDefault; // false
  @JsonKey(name: "ProjectId")
  final String projectId; // "0"
  @JsonKey(name: "SecurityGroupDesc")
  final String securityGroupDesc; // System created security group
  @JsonKey(name: "SecurityGroupId")
  final String securityGroupId; // sg-glrysr09
  @JsonKey(name: "SecurityGroupName")
  final String securityGroupName; // default
  @JsonKey(name: "TagSet")
  final List<String>? tagSet; // []
  @JsonKey(name: "UpdateTime")
  final String? updateTime; // 2022-05-25 14:12:29

  factory CVMSecurityGroup.fromJson(Map<String, dynamic> json) =>
      _$CVMSecurityGroupFromJson(json);
  Map<String, dynamic> toJson() => _$CVMSecurityGroupToJson(this);
}
