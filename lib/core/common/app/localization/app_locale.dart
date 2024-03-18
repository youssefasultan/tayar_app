// ignore_for_file: constant_identifier_names

mixin AppLocale {
  static const String appName = 'appName';
  static const String appSlogan = 'appSlogan';
  static const String telephoneNo = 'telephoneNo';
  static const String password = 'password';
  static const String forgotPassword = 'forgortPassword';
  static const String signIn = 'signIn';
  static const String createPass = 'createPassword';
  static const String confirmNewPassword = 'confirmNewPass';

  //profile
  static const String profile = 'profile';
  static const String logout = 'logout';
  static const String vehicleNo = 'vehicleNo';
  static const String report = 'report';
  static const String reportError = 'reportError';
  static const String choosetDate = 'chooseDate';

  //status
  static const String neW = 'new';
  static const String inProcess = 'inProcess';
  static const String delivered = 'delivered';
  static const String cancelled = 'cancelled';

  //driver insight
  static const String collected = 'collected';
  static const String cashOrders = 'cashOrders';

  // order
  static const String orders = 'orders';
  static const String orderNo = 'orderNo';
  static const String customerAddress = 'customerAddress';
  static const String customerPhone = 'customerPhone';
  static const String customerName = 'customerName';
  static const String paymentType = 'paymentType';
  static const String cash = 'cash';
  static const String card = 'card';
  static const String total = 'total';
  static const String egp = 'egp';
  static const String onOfItems = 'noOfItems';
  static const String orderStatus = 'orderStatus';
  static const String reason = 'reason';
  static const String submit = 'submit';
  static const String other = 'other';
  static const String enterReason = 'enterReason';

  //errors
  static const String noOrdersForStatus = 'noOrdersForStatus';
  static const String createPassError = 'CreatePassError';
  static const String noUserCacheError = 'noUserCacheFound';
  static const String phoneLengthError = 'phoneLengthError';
  static const String requiredFeild = 'requiredFeild';
  static const String cannotCall = 'cannotCall';

  //dialog
  static const String loading = 'loading';
  static const String successfully = 'successfully';

  static const Map<String, dynamic> EN = {
    appName: 'Tayar',
    appSlogan: 'Fast and Easy. Reach your Destination in a Minute.',
    requiredFeild: 'This Feild is Required',
    telephoneNo: 'Phone No.',
    password: 'Password',
    forgotPassword: 'Forgot Password?',
    signIn: 'Sign In',
    phoneLengthError: 'Phone Number must contain 11 number',
    createPass: 'Create Password',
    confirmNewPassword: 'Confirm Password',
    createPassError: 'must be the same as new password',
    noUserCacheError: 'No user found',
    orders: 'Orders',
    profile: 'Profile',
    logout: 'Logout',
    vehicleNo: 'Vehicle No.',
    neW: 'New',
    inProcess: 'In Process',
    delivered: 'Delivred',
    cancelled: 'Cancelled',
    collected: 'Collected Cash',
    cashOrders: 'Cash Orders',
    orderNo: 'Order #',
    customerAddress: 'Customer Address',
    customerPhone: 'Customer Phone',
    customerName: 'Customer Name',
    noOrdersForStatus: 'No Orders Found For this Status',
    paymentType: 'Payment Type',
    cash: 'Cash',
    card: 'Card',
    total: 'Total',
    egp: 'EGP',
    onOfItems: 'No. of Items',
    orderStatus: 'Order Status',
    cannotCall: 'Does not support call',
    loading: 'Please Wait...',
    successfully: 'Updated Successfully',
    reason: 'Reason',
    submit: 'Submit',
    other: 'Other',
    enterReason: 'Please Enter Reason',
    report: 'Report',
    reportError: 'No Data found',
    choosetDate: 'Choose Dates',
  };

  static const Map<String, dynamic> AR = {
    appName: 'طيار',
    appSlogan: 'بسرعه و سهوله. أوصل في دقيقه.',
    requiredFeild: 'هذاالحقل مطلوب',
    telephoneNo: 'رقم الهاتف',
    password: 'كلمه المرور',
    forgotPassword: 'نسيت كلمه المرور؟',
    signIn: 'دخول',
    phoneLengthError: 'رقم الهاتف يجب ان يتكون من 11 رقم',
    createPass: 'أنشاء كلمة مرور',
    confirmNewPassword: 'ادخل كلمه المرور مره اخري',
    createPassError: 'يجب أن تكون مثل كلمه المرور الجديده',
    noUserCacheError: 'لا يوجد مستخدم',
    orders: 'طلبات',
    profile: 'الصفحة الشخصية',
    logout: 'خروج',
    vehicleNo: 'رقم العربه',
    neW: 'جديد',
    inProcess: 'دائر',
    delivered: 'تم التوصيل',
    cancelled: 'ألغيت',
    collected: 'تم جمع',
    cashOrders: 'الطلبات النقدية',
    orderNo: 'رقم الاوردر',
    customerAddress: 'عنوان العميل',
    customerPhone: 'هاتف العميل',
    customerName: 'أسم العميل',
    noOrdersForStatus: 'لم يتم العثور على طلبات لهذه الحالة',
    paymentType: 'التحصيل',
    cash: 'نقدي',
    card: 'كارت',
    total: 'أجمالي',
    egp: 'جنيه مصري',
    onOfItems: 'عدد المنتجات',
    orderStatus: 'حاله الطلب',
    cannotCall: 'لا يمكن أستخدام الأتصال',
    loading: 'برجاء الأنظار',
    successfully: 'تم التحديث بنجاح',
    reason: 'السباب',
    submit: 'أتمام',
    other: 'أخري',
    enterReason: 'من فضلك ادخل السباب',
    report: 'أحصائيات',
    reportError: 'لا يوجد بيانات',
    choosetDate: 'أختار التاريخ',
  };
}
