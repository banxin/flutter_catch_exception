import 'dart:convert';

import 'package:flutter/services.dart';

/// flutter exception channel
class SYExceptionReportChannel {
  static const MethodChannel _channel =
      const MethodChannel('sy_exception_channel');

  // 上报异常
  static reportException(dynamic error, dynamic stack) {
    print('捕获的异常类型 >>> : ${error.runtimeType}');
    print('捕获的异常信息 >>> : $error');
    print('捕获的异常堆栈 >>> : $stack');

    Map reportMap = {
      'type': "${error.runtimeType}",
      'title': error.toString(),
      'description': stack.toString()
    };

    // 得使用这个
    print('这是通过convert转的json');
    print(jsonEncode(reportMap));

    // _channel.invokeListMethod('reportException', reportMap);
  }
}
