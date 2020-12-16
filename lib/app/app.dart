import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catch_exception/exception_report/custom_exception.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'crash catch',
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(),
    );

    // 异常测试 1 —— @山竹
    // return Container(
    //   child: MyHomePage(),
    // );

    // 异常测试 2 —— @山竹
    // return Text('test');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool sendFlag = false;
  static const MethodChannel _channel =
      const MethodChannel('shanzhu_crash_channel_main');
  RangeError error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch Exception'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text('dart 同步异常'),
                elevation: 1.0,
                onPressed: () {
                  if (sendFlag) {
                    print('同步异常发生之前 >>>>>>>>>>>');
                    throw SYReportException('发生一个dart 同步异常');
                  }

                  print('同步异常后的代码 <<<<<<<<<<<<');
                }),
            RaisedButton(
                child: Text('dart 异步异常'),
                elevation: 1.0,
                onPressed: () {
                  try {
                    Future.delayed(Duration(seconds: 1)).then((e) {
                      if (sendFlag) {
                        print('异步异常发生之前 >>>>>>>>>>>');
                        throw SYReportException('发生一个dart 异步异常');
                      }
                      print('异步异常后执行的代码 <<<<<<<<<<<');
                    });
                  } catch (e) {
                    print("这是不会执行的. ");
                  }
                }),
            RaisedButton(
                child: Text('点击修改flag，点击上面两个按钮才会发生异常'),
                elevation: 1.0,
                onPressed: () {
                  // List<String> numList = ['1', '2'];
                  // print(numList[6]);

                  // _channel.invokeListMethod('pushException', {
                  //   'errorMsg': 'error.toString()',
                  //   'stackDetails': 'stack.toString()'
                  // });
                  setState(() {
                    sendFlag = !sendFlag;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
