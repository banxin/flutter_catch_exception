// 自定义 上报 Exception
class SYReportException extends Error {
  final Object message;

  SYReportException(this.message);

  String toString() {
    if (message != null) {
      return "SYReportException: ${Error.safeToString(message)}";
    }
    return "SYReportException failed";
  }
}
