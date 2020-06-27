import 'package:permission_handler/permission_handler.dart';

class HandlePermission {
  HandlePermission._();
  static final permission = HandlePermission._();

  Future<bool> isContactPermitted() async {
    PermissionStatus contactStatus = await Permission.contacts.status;
    if (contactStatus == PermissionStatus.undetermined) {
      contactStatus = await Permission.contacts.request();
    }
    if (contactStatus == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
}
