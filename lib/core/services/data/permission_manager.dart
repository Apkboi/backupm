import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  /// checks for users permission
  static Future<PermissionStatus> _requestPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  /// returns true if status is granted
  static Future<bool> requestPermission(BuildContext context) async {
    final status = await _requestPermission();
    if (status != PermissionStatus.granted) {
      _handleInvalidPermissions(context, status);
      return false;
    }
    return true;
  }

  static void _handleInvalidPermissions(
      BuildContext context, PermissionStatus permissionStatus) async {
    switch (permissionStatus) {
      case PermissionStatus.denied:
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Access denied')));
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.restricted:
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('You are restricted from this action')));
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        await openAppSettings();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Access Not Available')));
        break;
    }
  }
}
