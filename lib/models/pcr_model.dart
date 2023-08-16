class PCRData {
  String? date;
  String? count; //make sure to define correct data type of response

  PCRData({this.date, this.count});

  factory PCRData.fromJson(Map<String, dynamic> json) {
    return PCRData(
      date: json["date"],
      count: json["pcr_count"]
    );
  }
}


