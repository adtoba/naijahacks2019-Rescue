import 'package:permission_handler/permission_handler.dart';


class PermissionService {

  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> _requestPermission(PermissionGroup permissionGroup) async {
    bool hasPermission = await _hasPermission(permissionGroup);
    print('Permission existence is $hasPermission');

    if(hasPermission) {
      return true;
    } else {
      Map<PermissionGroup, PermissionStatus> result = 
        await _permissionHandler.requestPermissions([permissionGroup]);

        if(result[permissionGroup] == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
    }
  }


  Future<bool> _hasPermission(PermissionGroup permissionGroup) async {
    PermissionStatus permissionStatus = await _permissionHandler.checkPermissionStatus(
      permissionGroup
    );

    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    bool granted = await _requestPermission(
      PermissionGroup.location
    );

    if(!granted) {
      onPermissionDenied();
    } 

    return granted;
  }

}