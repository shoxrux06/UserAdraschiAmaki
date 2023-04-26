class SignUpResponse {
  SignUpResponse({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
