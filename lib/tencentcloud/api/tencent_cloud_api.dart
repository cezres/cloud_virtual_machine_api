import 'package:cloud_virtual_machine_api/tencentcloud/api/base_tencent_cloud_api.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_image.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_inquiry_price.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_instance.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_instance_status.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_instance_type_config.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_region.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_security_group.dart';
import 'package:cloud_virtual_machine_api/tencentcloud/model/cvm_zone.dart';

///
/// https://console.cloud.tencent.com/api/explorer
///

///
/// 腾讯云服务器API
///
class TencentCloudApi {
  TencentCloudApi({required String secretId, required String secretKey})
      : region =
            TencentCloudRegionApi(secretId: secretId, secretKey: secretKey),
        instance =
            TencentCloudInstanceApi(secretId: secretId, secretKey: secretKey),
        image = TencentCloudImageApi(secretId: secretId, secretKey: secretKey),
        securityGroup = TencentCloudSecurityGroupApi(
            secretId: secretId, secretKey: secretKey);

  TencentCloudRegionApi region;
  TencentCloudInstanceApi instance;
  TencentCloudImageApi image;
  TencentCloudSecurityGroupApi securityGroup;

  void setSecret({required String secretId, required String secretKey}) {
    region = TencentCloudRegionApi(secretId: secretId, secretKey: secretKey);
    instance =
        TencentCloudInstanceApi(secretId: secretId, secretKey: secretKey);
    image = TencentCloudImageApi(secretId: secretId, secretKey: secretKey);
    securityGroup =
        TencentCloudSecurityGroupApi(secretId: secretId, secretKey: secretKey);
  }
}

///
/// 地域相关接口
///
class TencentCloudRegionApi extends BaseTencentCloudApi {
  TencentCloudRegionApi({required super.secretId, required super.secretKey})
      : super(service: "cvm");

  /// 查询地域列表
  Future<List<CVMRegion>> describeRegions() {
    return requestResults(
        action: "DescribeRegions",
        region: "",
        decodeKey: "RegionSet",
        decoder: CVMRegion.fromJson);
  }

  /// 查询可用区列表
  Future<List<CVMZone>> describeZones({required String region}) {
    return requestResults(
        action: "DescribeZones",
        region: region,
        decodeKey: "ZoneSet",
        decoder: CVMZone.fromJson);
  }
}

///
/// 实例相关接口
///
class TencentCloudInstanceApi extends BaseTencentCloudApi {
  TencentCloudInstanceApi({required super.secretId, required super.secretKey})
      : super(service: "cvm");

  /// 查询实例机型列表
  Future<List<CVMInstanceTypeConfig>> describeInstanceTypeConfigs(
      {required String region, required CVMZone zone}) {
    return requestResults(
        action: "DescribeInstanceTypeConfigs",
        region: region,
        params: {
          "Filters": [
            {
              "Name": "zone",
              "Values": [zone.zone],
            }
          ]
        },
        decodeKey: "InstanceTypeConfigSet",
        decoder: CVMInstanceTypeConfig.fromJson);
  }

  Future<CVMInquiryPrice> inquiryPriceRunInstances({
    required String region,
    required String instanceChargeType,
    required String zone,
    required String instanceType,
    required String imageId,
    String diskType = "CLOUD_PREMIUM",
    int diskSize = 20,
    int instanceCount = 1,
    String? instanceName,
    required String password,
    required List<String> securityGroupIds,
    String? maxPrice,
  }) {
    return requestResult(
        action: "InquiryPriceRunInstances",
        region: region,
        decodeKey: "Price",
        params: {
          "InstanceChargeType": instanceChargeType, // SPOTPAID
          "Placement": {
            "Zone": zone, // ap-hongkong-3
          },
          "InstanceType": instanceType, // SA2.SMALL1
          "ImageId": imageId, // img-l8og963d
          "SystemDisk": {
            "DiskType": diskType,
            "DiskSize": diskSize,
          },
          "VirtualPrivateCloud": {
            "VpcId": "DEFAULT",
            "SubnetId": "DEFAULT",
            "AsVpcGateway": false,
          },
          "InternetAccessible": {
            "InternetChargeType": "TRAFFIC_POSTPAID_BY_HOUR",
            "InternetMaxBandwidthOut": 100,
            "PublicIpAssigned": true,
          },
          "InstanceCount": instanceCount,
          "InstanceName": instanceName,
          "LoginSettings": {
            "Password": password,
          },
          "SecurityGroupIds": securityGroupIds, // [sg-glrysr09]
          "InstanceMarketOptions": {
            "MarketType": "spot",
            "SpotOptions": {
              "MaxPrice": maxPrice,
              "SpotInstanceType": "one-time",
            }
          }
        },
        decoder: CVMInquiryPrice.fromJson);
  }

  /// 创建实例
  Future<List<String>> runInstances({
    required String region,
    required String instanceChargeType,
    required String zone,
    required String instanceType,
    required String imageId,
    String diskType = "CLOUD_PREMIUM",
    int diskSize = 20,
    int instanceCount = 1,
    String? instanceName,
    required String password,
    required List<String> securityGroupIds,
    String? maxPrice,
  }) async {
    final response = await sendReeust(
      action: "RunInstances",
      region: region,
      params: {
        "InstanceChargeType": instanceChargeType, // SPOTPAID
        "Placement": {
          "Zone": zone, // ap-hongkong-3
        },
        "InstanceType": instanceType, // SA2.SMALL1
        "ImageId": imageId, // img-l8og963d
        "SystemDisk": {
          "DiskType": diskType,
          "DiskSize": diskSize,
        },
        "VirtualPrivateCloud": {
          "VpcId": "DEFAULT",
          "SubnetId": "DEFAULT",
          "AsVpcGateway": false,
        },
        "InternetAccessible": {
          "InternetChargeType": "TRAFFIC_POSTPAID_BY_HOUR",
          "InternetMaxBandwidthOut": 100,
          "PublicIpAssigned": true,
        },
        "InstanceCount": instanceCount,
        "InstanceName": instanceName,
        "LoginSettings": {
          "Password": password,
        },
        "SecurityGroupIds": securityGroupIds, // [sg-glrysr09]
        "InstanceMarketOptions": {
          "MarketType": "spot",
          "SpotOptions": {
            "MaxPrice": maxPrice,
            "SpotInstanceType": "one-time",
          }
        }
      },
    );
    return (response.data["Response"]["InstanceIdSet"] as List)
        .map((e) => e.toString())
        .toList();
  }

  /// 查看实例列表
  Future<List<CVMInstance>> describeInstances({
    required String region,
    List<String>? instanceIds,
    int? offset,
    int? limit,
  }) {
    return requestResults(
        action: "DescribeInstances",
        region: region,
        params: {
          "InstanceIds": instanceIds,
          "Offset": offset,
          "Limit": limit,
        },
        decodeKey: "InstanceSet",
        decoder: CVMInstance.fromJson);
  }

  /// 查看实例状态列表
  Future<List<CVMInstanceStatus>> describeInstancesStatus({
    required String region,
    List<String>? instanceIds,
    int? offset,
    int? limit,
  }) {
    return requestResults(
        action: "DescribeInstancesStatus",
        region: region,
        decodeKey: "InstanceStatusSet",
        params: {
          "InstanceIds": instanceIds,
          "Offset": offset,
          "Limit": limit,
        },
        decoder: CVMInstanceStatus.fromJson);
  }

  /// 关闭实例
  Future<void> stopInstances(
      {required String region, required List<String> instanceIds}) async {
    await sendReeust(
      action: "StopInstances",
      region: region,
      params: {
        "InstanceIds": instanceIds,
        "StopType": "SOFT_FIRST",
      },
    );
  }

  /// 启动实例
  Future<void> startInstances(
      {required String region, required List<String> instanceIds}) async {
    await sendReeust(
      action: "StartInstances",
      region: region,
      params: {
        "InstanceIds": instanceIds,
      },
    );
  }

  /// 重启实例
  Future<void> rebootInstances(
      {required String region, required List<String> instanceIds}) async {
    await sendReeust(
      action: "RebootInstances",
      region: region,
      params: {
        "InstanceIds": instanceIds,
        "StopType": "SOFT_FIRST",
      },
    );
  }

  /// 退还实例
  Future<void> terminateInstances(
      {required String region, required List<String> instanceIds}) async {
    await sendReeust(
      action: "TerminateInstances",
      region: region,
      params: {
        "InstanceIds": instanceIds,
      },
    );
  }
}

///
/// 镜像相关接口
///
class TencentCloudImageApi extends BaseTencentCloudApi {
  TencentCloudImageApi({required super.secretId, required super.secretKey})
      : super(service: "cvm");

  /// 查看镜像列表
  Future<List<CVMImage>> describeImages(
      {required String region, String? platform}) async {
    List<Map<String, dynamic>> filters = [
      {
        "Name": "image-type",
        "Values": ["PUBLIC_IMAGE"]
      }
    ];
    if (platform != null) {
      filters.add({
        "Name": "platform",
        "Values": [platform]
      });
    }
    return requestResults(
        action: "DescribeImages",
        region: region,
        params: {
          "Filters": filters,
        },
        decodeKey: "ImageSet",
        decoder: CVMImage.fromJson);
  }
}

///
/// 安全组相关接口
///
class TencentCloudSecurityGroupApi extends BaseTencentCloudApi {
  TencentCloudSecurityGroupApi(
      {required super.secretId, required super.secretKey})
      : super(service: "vpc");

  /// 查看安全组
  Future<List<CVMSecurityGroup>> describeSecurityGroups(
      {required String region}) async {
    return requestResults(
        action: "DescribeSecurityGroups",
        region: region,
        decodeKey: "SecurityGroupSet",
        decoder: CVMSecurityGroup.fromJson);
  }

  /// 创建安全组和规则 (放通全部端口)
  /// https://console.cloud.tencent.com/api/explorer?Product=vpc&Version=2017-03-12&Action=CreateSecurityGroupWithPolicies
  Future<CVMSecurityGroup> createSecurityGroupWithPolicies(
      {required String region,
      required String groupName,
      required String groupDescription}) {
    return requestResult(
        action: "CreateSecurityGroupWithPolicies",
        region: region,
        decodeKey: "SecurityGroup",
        params: {
          "GroupName": groupName,
          "GroupDescription": groupDescription,
          "SecurityGroupPolicySet": {
            "Version": "1",
            "Egress": [
              {
                "PolicyIndex": 0,
                "Protocol": "ALL",
                "Port": "all",
                "CidrBlock": "0.0.0.0/0",
                "Action": "ACCEPT",
              },
              {
                "PolicyIndex": 1,
                "Protocol": "ALL",
                "Port": "all",
                "Ipv6CidrBlock": "::/0",
                "Action": "ACCEPT",
              },
            ],
            "Ingress": [
              {
                "PolicyIndex": 0,
                "Protocol": "ALL",
                "Port": "all",
                "CidrBlock": "0.0.0.0/0",
                "Action": "ACCEPT",
              },
              {
                "PolicyIndex": 1,
                "Protocol": "ALL",
                "Port": "all",
                "Ipv6CidrBlock": "::/0",
                "Action": "ACCEPT",
              },
            ],
          }
        },
        decoder: CVMSecurityGroup.fromJson);
  }
}
