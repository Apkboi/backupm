extension DateTimeExtensio on DateTime{

  String get toCustomString =>" ${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
}