class ForgotPasswordResponse {
  ForgotPasswordResponse({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}