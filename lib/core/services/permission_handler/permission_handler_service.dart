import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  Future<bool> requestPermission(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) {
      // Permission already granted
      return true;
    } else {
      // Request permission
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  Future<bool> requestMultiplePermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    return statuses.values.every((status) => status.isGranted);
  }

  Future<bool> checkPermissionStatus(Permission permission) async {
    var status = await permission.status;
    return status.isGranted;
  }
}
