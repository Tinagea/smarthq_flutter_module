
import 'package:smarthq_flutter_module/resources/channels/channel_data_item.dart';
import 'package:smarthq_flutter_module/resources/channels/ble_commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/commissioning_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_channel_profile.dart';
import 'package:smarthq_flutter_module/resources/channels/native_channel_profile.dart';

import 'local_appliance_commissioning_channel_profile.dart';

class ChannelItem {
  final ChannelDataItem? dataItem;
  const ChannelItem(this.dataItem);
}

class NativeChannelItem extends ChannelItem {
  final NativeChannelListenType type;
  const NativeChannelItem(this.type, ChannelDataItem? dataItem): super(dataItem);
}

class CommissioningChannelItem extends ChannelItem {
  final CommissioningChannelListenType type;
  const CommissioningChannelItem(this.type, ChannelDataItem? dataItem): super(dataItem);
}

class BleCommissioningChannelItem extends ChannelItem {
  final BleCommissioningChannelListenType type;
  const BleCommissioningChannelItem(this.type, ChannelDataItem? dataItem): super(dataItem);
}

class LocalApplianceCommissioningChannelItem extends ChannelItem {
  final LocalApplianceCommissioningChannelListenType type;
  const LocalApplianceCommissioningChannelItem(this.type, ChannelDataItem? dataItem): super(dataItem);
}

class DialogChannelItem extends ChannelItem {
  final DialogChannelListenType type;
  const DialogChannelItem(this.type, ChannelDataItem? dataItem): super(dataItem);
}

class ShortcutServiceChannelItem extends ChannelItem {
  // final ShortcutServiceChannelListenType type;
  const ShortcutServiceChannelItem(//this.type,
      ChannelDataItem? dataItem): super(dataItem);
}
