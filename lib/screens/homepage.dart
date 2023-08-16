import 'package:covid_app/models/covid_data_model.dart';
import 'package:covid_app/models/pcr_model.dart';
import 'package:covid_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/custom_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Create a class object
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //to get screen width

    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder(
        future: apiService.getData(), //call future method
        builder: (context, snapshot) {
          //create builder
          if (snapshot.hasData) {
            CovidDataModel data = snapshot.data!; // mark is can be nullable
            List<PCRData> pcrDataList = data.pcrData!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.menu),
                      Text("Covid 19 Tracker",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700)),
                      Icon(Icons.location_city)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        size: size,
                        color: Colors.red,
                        title: "Local Deaths",
                        value: data.totalCases!.toInt(),
                      ),
                      CustomContainer(
                        size: size,
                        color: Colors.green,
                        title: 'Local Recovered',
                        value: data.totalRecovered!.toInt(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        size: size,
                        color: Colors.amber,
                        title: "Global Deaths",
                        value: data.totalDeath!.toInt(),
                      ),
                      CustomContainer(
                        size: size,
                        color: Colors.blue,
                        title: 'Active Cases',
                        value: data.activeCases!.toInt(),
                      ),
                    ],
                  ),
                  Text(
                    "Daily PCR Tests",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pcrDataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: Text(pcrDataList[index].count.toString()),
                        title: Text(pcrDataList[index]
                            .date
                            .toString()), // Use title instead of style
                      );
                    },
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
