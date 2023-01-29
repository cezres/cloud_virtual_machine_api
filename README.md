# cloud_virtual_machine_api



```dart
const secretId = "";
const secretKey = "";
final TencentCloudApi api =
    TencentCloudApi(secretId: secretId, secretKey: secretKey);

final regions = await api.region.describeRegions();

final CVMRegion region =
    regions.firstWhere((element) => element.regionName.contains("香港"));

final zones = await api.region.describeZones(region: region.region);
final CVMZone zone =
    zones.firstWhere((element) => element.zoneState != "UNAVAILABLE");

final instanceTypeConfigs = await api.instance
    .describeInstanceTypeConfigs(region: region.region, zone: zone);
final CVMInstanceTypeConfig instanceTypeConfig = instanceTypeConfigs.first;

final images = await api.image
    .describeImages(region: region.region, platform: "CentOS");
final CVMImage image =
    images.firstWhere((element) => element.osName == "CentOS 7.9 64位");

final securityGroups =
    await api.securityGroup.describeSecurityGroups(region: region.region);

/// 创建安全组
final int securityGroupIndex = securityGroups.indexWhere((element) {
    if (element.securityGroupName.isEmpty ||
        element.securityGroupDesc.length != 32) {
    return false;
    }
    final string =
        (element.updateTime ?? element.createdTime).split(" ").first;

    final bytes = utf8.encode(string);
    var digest = md5.convert(bytes);
    if (digest.toString() == element.securityGroupDesc) {
    return true;
    }
    return false;
});
String securityGroupId = "";
if (securityGroupIndex == -1) {
    final DateTime dateTime = DateTime.now();
    final dateString =
        "${dateTime.year}-${dateTime.month > 10 ? "" : "0"}${dateTime.month}-${dateTime.day > 10 ? "" : "0"}${dateTime.day}";
    final bytes = utf8.encode(dateString);
    final digest = md5.convert(bytes);
    final groupDescription = digest.toString();

    securityGroupId = (await api.securityGroup
            .createSecurityGroupWithPolicies(
                region: region.region,
                groupName: "放通全部端口-${dateTime.millisecondsSinceEpoch}",
                groupDescription: groupDescription))
        .securityGroupId;
} else {
    securityGroupId = securityGroups[securityGroupIndex].securityGroupId;
}

/// 查询价格
final CVMInquiryPrice inquiryPrice = await api.instance
    .inquiryPriceRunInstances(
        region: region.region,
        instanceChargeType: "SPOTPAID",
        zone: zone.zone,
        instanceType: instanceTypeConfig.instanceType,
        imageId: image.imageId,
        password: "Azusa2233",
        securityGroupIds: [securityGroupId],
        maxPrice: "1");

/// 创建实例
final instanceIds = await api.instance.runInstances(
    instanceName: "test001",
    region: region.region,
    instanceChargeType: "SPOTPAID",
    zone: zone.zone,
    instanceType: instanceTypeConfig.instanceType,
    imageId: image.imageId,
    password: "Password001",
    securityGroupIds: [securityGroupId],
    maxPrice: "${inquiryPrice.instancePrice.unitPriceDiscount * 2}");

/// 查询实例状态
await Future.delayed(const Duration(seconds: 20));
while (true) {
    await Future.delayed(const Duration(seconds: 4));
    final instances = await api.instance.describeInstancesStatus(
        region: region.region, instanceIds: instanceIds);
    final result = instances
        .map((e) => e.instanceState != "PENDING")
        .toList()
        .reduce((value, element) => value && element);
    if (result) {
    break;
    }
}

/// 退还实例
await api.instance
    .terminateInstances(region: region.region, instanceIds: instanceIds);
await api.instance.describeInstancesStatus(
    region: region.region, instanceIds: instanceIds);
```