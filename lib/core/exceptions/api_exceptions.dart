import 'package:dio/dio.dart';

class ApiExceptions implements Exception {
  int? statusCode;
  String? message;
  String? code;
  Map<String, dynamic>? data;

//<editor-fold desc="Data Methods">
  ApiExceptions({
    this.statusCode,
    this.message,
    this.code,
    this.data,
  });

  factory ApiExceptions.fromDioError(DioError dioError) {
    return ApiExceptions(
      statusCode: dioError.response?.statusCode,
      message: dioError.error?.toString(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiExceptions &&
          runtimeType == other.runtimeType &&
          statusCode == other.statusCode &&
          message == other.message &&
          code == other.code &&
          data == other.data);

  @override
  int get hashCode =>
      statusCode.hashCode ^ message.hashCode ^ code.hashCode ^ data.hashCode;

  @override
  String toString() {
    return 'ApiExceptions{' +
        ' statusCode: $statusCode,' +
        ' message: $message,' +
        ' code: $code,' +
        ' data: $data,' +
        '}';
  }

  ApiExceptions copyWith({
    int? statusCode,
    String? message,
    String? code,
    Map<String, dynamic>? data,
  }) {
    return ApiExceptions(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      code: code ?? this.code,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': this.statusCode,
      'message': this.message,
      'code': this.code,
      'data': this.data,
    };
  }

  factory ApiExceptions.fromMap(Map<String, dynamic> map) {
    return ApiExceptions(
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
      code: map['code'] as String,
      data: map['data'] as Map<String, dynamic>,
    );
  }

//</editor-fold>
}