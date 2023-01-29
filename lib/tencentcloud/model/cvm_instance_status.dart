import 'package:json_annotation/json_annotation.dart';

part 'cvm_instance_status.g.dart';

@JsonSerializable()
class CVMInstanceStatus {
  const CVMInstanceStatus(this.instanceId, this.instanceState);

  @JsonKey(name: "InstanceId")
  final String instanceId;
  @JsonKey(name: "InstanceState")
  final String instanceState;

  factory CVMInstanceStatus.fromJson(Map<String, dynamic> json) =>
      _$CVMInstanceStatusFromJson(json);
  Map<String, dynamic> toJson() => _$CVMInstanceStatusToJson(this);

  @override
  String toString() {
    return "CVMInstanceStatus: $instanceId $instanceState";
  }
}
