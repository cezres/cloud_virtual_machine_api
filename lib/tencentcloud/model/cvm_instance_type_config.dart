import 'package:json_annotation/json_annotation.dart';

part 'cvm_instance_type_config.g.dart';

@JsonSerializable()
class CVMInstanceTypeConfig {
  const CVMInstanceTypeConfig(this.cpu, this.fpga, this.gpu, this.memory,
      this.instanceFamily, this.instanceType, this.zone);

  @JsonKey(name: "CPU")
  final int cpu; // 1
  @JsonKey(name: "FPGA")
  final int fpga; // 0
  @JsonKey(name: "GPU")
  final int gpu; // 0
  @JsonKey(name: "Memory")
  final int memory; // 1
  @JsonKey(name: "InstanceFamily")
  final String instanceFamily; // S2
  @JsonKey(name: "InstanceType")
  final String instanceType; // S2.SMALL1
  @JsonKey(name: "Zone")
  final String zone; // ap-hongkong-2

  factory CVMInstanceTypeConfig.fromJson(Map<String, dynamic> json) =>
      _$CVMInstanceTypeConfigFromJson(json);
  Map<String, dynamic> toJson() => _$CVMInstanceTypeConfigToJson(this);

  @override
  String toString() {
    String string = "$instanceFamily $cpu核 ${memory}G";
    if (gpu > 0) {
      string += " ${gpu}GPU";
    }
    if (fpga > 0) {
      string += " ${fpga}FPGA";
    }
    return string;
  }

  @override
  bool operator ==(Object other) {
    return other is CVMInstanceTypeConfig && instanceType == other.instanceType;
  }

  @override
  int get hashCode => instanceType.hashCode;
}
