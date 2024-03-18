import 'dart:convert';

const kBaseUrl = '20.245.156.26';
const kSignInEndPoint = '/ECS_RPOS_T001/Api/driver/login';
const kCreatePassEndPoint = '/ECS_RPOS_T001/Api/DriverNewPassword';
const kGetOrdersEndPoint = '/ECS_RPOS_T001/DriverAllOrders';
const kUpdateOrderStatus = '/ECS_RPOS_T001/Api/UpdateOrderStatus';
const kGetCancelReasonsEndPoint =
    '/ECS_RPOS_T001/Api/DynamicQuery/Cancel_Reasons';
const kGetWeeklyReportEndPoint = '/ECS_RPOS_T001/Api/DriverWeeklyOrders';

Map<String, String> buildGetEndPointParams(
  String orgId,
  String driverId,
) =>
    {
      'driverId': driverId,
      'orgId': orgId,
    };

const kOrgId = '10';
const serverUsername = 'Ecs';
const serverPass = 'ApiSecurityKey0063@Ecs';

String basicAuth =
    'Basic ${base64Encode(utf8.encode('$serverUsername:$serverPass'))}';

Map<String, String> kHeader = {
  'Authorization': basicAuth,
  'content-type': 'application/json',
};

const List<String> langList = ['English', 'عربي'];

const String loggedUserKey = 'user';
const String logStatusKey = 'status';
