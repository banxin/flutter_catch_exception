import 'dart:async';

import 'package:flutter/material.dart';

/// 工具类
class ExceptionReportUtil {
  // 比较巧妙的一种方式判定是否是debug模式
  static bool get isInDebugMode {
    bool inDebugMode = false;
    // 如果debug模式下会触发赋值，只有在debug模式下才会执行assert
    assert(inDebugMode = true);
    return inDebugMode;
  }

  // 初始化异常捕获配置
  static void initExceptionCatchConfig() {
    // framework异常捕获，转发到当前的 Zone
    FlutterError.onError = (FlutterErrorDetails details) async {
      // // debug模式
      // if (ExceptionReportUtil.isInDebugMode) {
      //   // 打印到控制台
      //   FlutterError.dumpErrorToConsole(details);

      //   // release模式
      // } else {
      //   // 转发到zone
      //   Zone.current.handleUncaughtError(details.exception, details.stack);
      // }

      // debug 模式下测试
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };

    // 重写 ErrorWidget 的builder，显示地优雅一些
    ErrorWidget.builder = (FlutterErrorDetails details) {
      print('错误widget详细的错误信息为：' + details.toString());

      return MaterialApp(
        title: 'Error Widget',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Widget渲染异常！！！'),
          ),
          body: _createBody(details),
        ),
      );
    };
  }

  // 创建错误widget body
  static Widget _createBody(dynamic details) {
    // 正确代码
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            details.toString(),
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  // 测试异常 @山竹
  // return Column(
  //   children: <Widget>[
  //     Text(
  //       details.toString(),
  //       style: TextStyle(color: Colors.red),
  //     )
  //   ],
  // );
}
