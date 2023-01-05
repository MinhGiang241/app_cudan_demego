class RegexText {
  static const vietLetter =
      r'[àÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬđĐèÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆìÌỉỈĩĨíÍịỊòÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰỳỲỷỶỹỸýÝỵỴ]';
  static bool vietNameseChar(String value) => RegExp(
        r'[àÀảẢãÃáÁạẠăĂằẰẳẲẵẴắẮặẶâÂầẦẩẨẫẪấẤậẬđĐèÈẻẺẽẼéÉẹẸêÊềỀểỂễỄếẾệỆìÌỉỈĩĨíÍịỊòÒỏỎõÕóÓọỌôÔồỒổỔỗỖốỐộỘơƠờỜởỞỡỠớỚợỢùÙủỦũŨúÚụỤưƯừỪửỬữỮứỨựỰỳỲỷỶỹỸýÝỵỴ]',
      ).hasMatch(value);
  static bool onlyZero(String value) => RegExp(r'[1-9]').hasMatch(value);

  static bool minMaxString({required String value, int? min, int? max}) =>
      RegExp("^.{$min,$max}\$").hasMatch(value);

  static bool isEmail(String value) =>
      // RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
      RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$').hasMatch(value);

  static bool requiredUpperCase(String value) =>
      RegExp(r"(.*[A-Z].*)").hasMatch(value);

  static bool requiredLowerCase(String value) =>
      RegExp(r"(.*[a-z].*)").hasMatch(value);

  static bool requiredNumber(String value) =>
      RegExp(r"(.*[0-9].*)").hasMatch(value);

  static bool requiredSpecialChar(String value) =>
      RegExp(
        r'''(?=.*[@$!%*#?&)(\-+=\[\]\{\}\.\,<>\'\`~:;\\|/])[A-Za-z\d@$!%*_#?&\[\]\(\)<>`\'+-={}"|\\/]''',
      ).hasMatch(value) ||
      RegExp(
        r'''["]''',
      ).hasMatch(value);
}
