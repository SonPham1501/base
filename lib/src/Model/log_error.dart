class LogError {
  String? date;
  String? messageError;
  String? body;
  String? url;

  LogError({
    this.date,
    this.messageError,
    this.body,
    this.url,
  });

  LogError.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    messageError = json['messageError'] as String?;
    body = json['body'] as String?;
    url = json['url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['date'] = date;
    json['messageError'] = messageError;
    json['body'] = body;
    json['url'] = url;
    return json;
  }
}