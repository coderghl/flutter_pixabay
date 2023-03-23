import 'package:permission_handler/permission_handler.dart';

class PermissionUtil{
  static Future<bool> checkPermission(Permission permission)async{
    var status = await permission.status;
    return status.isGranted;
  }


  static Future<bool> requestPermission(Permission permission) async{
    var status = await permission.request();
    return status.isGranted;
  }
}
