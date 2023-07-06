

abstract class ApplianceServiceAction {
  const ApplianceServiceAction();
}

class ApplianceServicePostErdAction extends ApplianceServiceAction {
  final String jid;
  final String erdNumber;
  final String erdValue;
  const ApplianceServicePostErdAction(this.jid, this.erdNumber, this.erdValue);
}

class ApplianceServiceCacheAction extends ApplianceServiceAction {
  final String jid;
  const ApplianceServiceCacheAction(this.jid);
}