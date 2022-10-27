import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

import '../generated/l10n.dart';

enum ErrorType {
  loginError,
  networkError,
  serverError,
}

class ErrorHandle {
  ErrorHandle({msg, this.code = 0, this.type}) : _msg = msg;
  String? _msg;
  final int code;
  final ErrorType? type;
  set msg(String value) {
    _msg = value;
  }

  String get msg {
    if (type != null) {
      return mapErrorTypeToMsg(type!);
    }
    return _msg ?? '';
  }
}

String mapErrorTypeToMsg(ErrorType type) {
  switch (type) {
    case ErrorType.loginError:
      return '';
    case ErrorType.networkError:
      return S.current.err_internet;
    default:
      return S.current.err_unknown;
  }
}
