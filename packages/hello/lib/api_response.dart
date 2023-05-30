class ApiResponse {

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
      statusCode: json.containsKey('statusCode') ? json['statusCode'] : 0,
      total: json.containsKey('total') ? json['total'] : 0,
      page: json.containsKey('page') ? json['page'] : 0,
      perPage: json.containsKey('perPage') ? json['perPage'] : 0,
      message: json.containsKey('message') ? json['message'] : null,
      data: json.containsKey('data') ? json['data'] : null,
      error: json.containsKey('error') ? json['error'] : null);
  ApiResponse(
      {this.statusCode,
      this.total,
      this.page,
      this.perPage,
      this.message,
      this.data,
      this.error});

  int? statusCode;
  int? total;
  int? page;
  int? perPage;
  dynamic message;
  dynamic error;
  dynamic data;

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'total': total,
        'message': message,
        'data': data,
        'error': error
      };

  @override
  String toString() {
    return 'ApiResponse{statusCode: $statusCode, total: $total, message: $message, data: $data, error: $error}';
  }
}

class CustomResponse {
  CustomResponse.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    data = json['Data'];
    message = json['Message'];
  }
  String code = '0';
  dynamic data;
  String message = '';

  bool isSuccess() {
    return code == '0';
  }
}

class ActionResponse {
  ActionResponse({this.isActionSuccess, this.message});

  factory ActionResponse.fromJson(Map<String, dynamic> json) => ActionResponse(
        isActionSuccess: json.containsKey('is_action_success')
            ? json['is_action_success']
            : false,
        message: json.containsKey('thong_bao') ? json['thong_bao'] : '',
      );
  final bool? isActionSuccess;
  final String? message;

  bool isSuccess() {
    return isActionSuccess ?? false;
  }
}

