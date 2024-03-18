import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.driverId,
    required this.fullName,
    required this.isActive,
    required this.isInitial,
    required this.isLocked,
    required this.orgId,
    required this.phoneNo,
    required this.vehicleNo,
  });

  const UserEntity.empty()
      : this(
          driverId: 0,
          fullName: '',
          isActive: true,
          isInitial: true,
          isLocked: false,
          orgId: 0,
          vehicleNo: '',
          phoneNo: '',
        );

  final int driverId;
  final String fullName;
  final String phoneNo;
  final String vehicleNo;
  final bool isActive;
  final bool isInitial;
  final bool isLocked;
  final int orgId;

  @override
  List<Object?> get props => [driverId, orgId];

  @override
  String toString() {
    return 'Driver(id: $driverId , name: $fullName, isActive: $isActive,'
        ' isInitial: $isInitial, isLocked: $isLocked, orgId: $orgId,'
        ' phoneNo: $phoneNo, vehicleNo: $vehicleNo)';
  }
}
