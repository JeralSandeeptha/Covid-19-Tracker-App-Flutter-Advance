import 'package:covid_app/models/pcr_model.dart';

class CovidDataModel {
  int? totalDeath;
  int? totalRecovered;
  int? totalCases;
  int? activeCases;
  List<PCRData>? pcrData;

  CovidDataModel(
      {this.totalDeath,
      this.totalRecovered,
      this.totalCases,
      this.activeCases,
      this.pcrData});

  factory CovidDataModel.fromJson(Map<String, dynamic> json) {
    List<PCRData> pcrDataList = (json["daily_pcr_testing_data"] as List)
        .map((day) => PCRData.fromJson(day))
        .toList();

    return CovidDataModel(
        activeCases: json['local_active_cases'],
        totalCases: json['local_total_cases'],
        totalDeath: json['local_deaths'],
        totalRecovered: json['local_recovered'],
        pcrData: pcrDataList);
  }
}
