class DogImageDTO {
  String message;
  String status;

  DogImageDTO({required this.message, required this.status});

  factory DogImageDTO.fromJson(Map<String, dynamic> json) {
    return DogImageDTO(
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