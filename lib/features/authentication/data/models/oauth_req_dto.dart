/// token : "eyJhbGciOiJSUzI1NiIsImtpZCI6ImY0ZTc2NDk3ZGE3Y2ZhOWNjMDkwZDcwZTIyNDQ2YTc0YjVjNTBhYTkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTGVvbiBDaHV4IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBVFhBSndsSDRuSkx4UUVCZk10R3J4NTdQaWtnQXU5bXBuN0ItQ3J6RnQtZlE9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZWRva28tZGU2NDkiLCJhdWQiOiJlZG9rby1kZTY0OSIsImF1dGhfdGltZSI6MTY1NDIwMzI5NCwidXNlcl9pZCI6InpXRmQxTUZyRWhRMktBNzNabXh5VFZKSUR4eTIiLCJzdWIiOiJ6V0ZkMU1GckVoUTJLQTczWm14eVRWSklEeHkyIiwiaWF0IjoxNjU0MjAzMjk0LCJleHAiOjE2NTQyMDY4OTQsImVtYWlsIjoiZXBpY2dlbmlpMThAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZ29vZ2xlLmNvbSI6WyIxMDk4NTQ5MDA4NzM3MTU3NTkzODIiXSwiZW1haWwiOlsiZXBpY2dlbmlpMThAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.F2KJTtD5kwJmLyi5iJQ1pDF_MF0AGNdQxaQk9ZeK-uoyTsaQ1BlOO_tz3tStOZHiMCjWdgxiCR9ewh2IPsbFckJ_TFaY73JFZw7TYSbVETo508gjjOBt66huQTe2CluZvTVgIUpaGUA4R_IxCXnl1VNYDkUFMSQ_MjVB6W5ec0ib-7MxAJXnXS6hlLVxMSspKb8MlyT6knhq19Ot6KatVN1rGbGC4CewprKueaj0ZgQ0Rjfp-o_sm_nTMvuRLxWVcoa2iu2ctnzBveLMPnY_586HXnso1wHrRL4JPdZmgzmMPNJUjw0WHZdMcsepysdQAv-J4XsQ1roA7nPu0-fa0w"
/// provider : "google"

class OauthReqDto {
  OauthReqDto({
    this.token,
    this.provider,
    this.fcmToken,
    this.apnToken,
  });

  OauthReqDto.fromJson(dynamic json) {
    token = json['token'];
    provider = json['provider'];
    fcmToken = json['fcm_token'];
    fcmToken = json['apn_token'];
  }

  String? token;
  String? provider;
  String? fcmToken;
  String? apnToken;

  OauthReqDto copyWith({
    String? token,
    String? provider,
    String? fcmToken,
    String? apnToken,
  }) =>
      OauthReqDto(
        token: token ?? this.token,
        provider: provider ?? this.provider,
        fcmToken: fcmToken ?? this.fcmToken,
        apnToken: apnToken ?? this.apnToken,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['provider'] = provider;
    map['fcm_token'] = fcmToken;
    map['apn_token'] = apnToken;
    return map;
  }
}
