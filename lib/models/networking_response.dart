class NetworkingResponse {
  Map<String, dynamic>? data;
  String? errorMessage;
  bool? isException;
  String? message;
  String? status;

  NetworkingResponse(
      {this.data,
      this.errorMessage,
      this.isException,
      this.message,
      this.status});

  NetworkingResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    errorMessage = json['error_message'];
    isException = json['is_exception'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    data!['data'] = this.data;
    data!['error_message'] = this.errorMessage;
    data!['is_exception'] = this.isException;
    data!['message'] = this.message;
    data!['status'] = this.status;
    return data!;
  }
}
