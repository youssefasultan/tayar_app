import 'package:tayar_app/core/utils/typedefs.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';

class LogInResponse {
  LogInResponse({this.users, this.message, this.rCode});

  LogInResponse.fromJson(DataMap json) {
    if (json['driver'] != null) {
      users = [];
      for (final element in json['driver'] as List<dynamic>) {
        users!.add(UserModel.fromMap(element as DataMap));
      }
    }
    message = json['message'] != null ? json['message'] as String : null;
    rCode = json['rCode'] != null ? json['rCode'] as String : null;
  }

  List<UserModel>? users;
  String? message;
  String? rCode;

  Map<String, dynamic> toJson() {
    final data = DataMap();
    if (users != null) {
      data['driver'] = users!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['rCode'] = rCode;
    return data;
  }
}
