import 'dart:convert';

import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.driverId,
    required super.fullName,
    required super.isActive,
    required super.isInitial,
    required super.isLocked,
    required super.orgId,
    required super.phoneNo,
    required super.vehicleNo,
  });

  UserModel.fromMap(DataMap map)
      : this(
          driverId: map['driverID'] as int,
          fullName: map['fullName'] as String,
          isActive: map['userActive'] as bool,
          isInitial: map['isInitial'] as bool,
          isLocked: map['locked'] as bool,
          orgId: map['org_ID'] as int,
          phoneNo: map['phoneNo'] as String,
          vehicleNo: map['vehicle_no'] as String,
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  const UserModel.empty()
      : this(
          driverId: 0,
          fullName: '',
          isActive: true,
          isInitial: true,
          isLocked: false,
          orgId: 0,
          phoneNo: '',
          vehicleNo: '',
        );

  UserModel copyWith({
    int? driverId,
    String? fullName,
    bool? isActive,
    bool? isInitial,
    bool? isLocked,
    int? orgId,
    String? phoneNo,
    String? vehicleNo,
  }) {
    return UserModel(
      driverId: driverId ?? this.driverId,
      fullName: fullName ?? this.fullName,
      isActive: isActive ?? this.isActive,
      isInitial: isInitial ?? this.isInitial,
      isLocked: isLocked ?? this.isLocked,
      orgId: orgId ?? this.orgId,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }

  DataMap toMap() => {
        'driverID': driverId,
        'fullName': fullName,
        'userActive': isActive,
        'isInitial': isInitial,
        'locked': isLocked,
        'org_ID': orgId,
        'phoneNo': phoneNo,
        'vehicle_no': vehicleNo,
      };

  String toJson() => jsonEncode(toMap());
}
