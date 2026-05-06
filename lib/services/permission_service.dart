import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkStoragePermission() async {
    final status = await Permission.storage.status;
    return status.isGranted;
  }
}