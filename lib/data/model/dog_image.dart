class DogImage {
  final String message;
  final String status;

  const DogImage({required this.message, required this.status});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": this.message,
      "status": this.status,
    };
  }

}