import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_catch_exception/app/app.dart';

import 'exception_report/exception_report_channel.dart';
import 'exception_report/exception_report_util.dart';

main(List<String> args) {
  // 初始化Exception 捕获配置
  ExceptionReportUtil.initExceptionCatchConfig();

  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    // 这个闭包中发生的Exception是捕获不到的 @山竹
    SYExceptionReportChannel.reportException(error, stackTrace);
  }, zoneSpecification: ZoneSpecification(
    print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      // 记录所有的打印日志
      parent.print(zone, "line是啥：$line");
    },
  ));
}
