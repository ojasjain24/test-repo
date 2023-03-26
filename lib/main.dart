import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:water_level_app/water_model.dart';

import 'api.dart';
// import 'notification_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Level',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WaterApi waterApi = WaterApi();
  Water myWater = Water();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Noti.initialize(flutterLocalNotificationsPlugin);

    waterApi.getExperienceList().then((List<Water> value) {
      setState(() {
        int length = value.length;
        myWater = value[length - 1];
        // myWater.field1 = "100";
        // if (int.parse("${myWater.field1}") <= 25) {
        //   Noti.showBigTextNotification(
        //       title: "Water Level Critically Low",
        //       body: "Turn on the water supply",
        //       fln: flutterLocalNotificationsPlugin);
        // }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: neonAppBar(
          context: context,
          heading: "Water Level Indicator",
          backgroundColor: Colors.blueGrey),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    NeonText(
                      text: "Voltage Level \n ${myWater.field2}",
                      spreadColor: Colors.blue,
                      blurRadius: 30,
                      textSize: 30,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        NeonText(
                          text: "Water Level \n ${myWater.field1}",
                          spreadColor: Colors.blue,
                          blurRadius: 30,
                          textSize: 30,
                        ),
                        Column(
                          children: [
                            for (int x = 0;
                                x < int.parse(myWater.field1 ?? "0") / 25;
                                x++) ...[
                              const NeonContainer(
                                height: 80,
                                spreadColor: Colors.blue,
                                width: 200,
                                containerColor: Colors.blue,
                                lightBlurRadius: 0,
                                lightSpreadRadius: 0,
                                borderColor: Colors.blue,
                                child: SizedBox(height: 40),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ],
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FlickerNeonPoint(
                      pointSize: 5,
                      lightSpreadRadius: 20,
                      lightBlurRadius: 40,
                      flickerTimeInMilliSeconds:
                          (int.parse(myWater.field1 ?? "0") <= 25) ? 750 : 0,
                      spreadColor: (int.parse(myWater.field1 ?? "0") <= 25)
                          ? Colors.red
                          : (int.parse(myWater.field1 ?? "0") == 100)
                              ? Colors.green
                              : Colors.orange,
                    )
                  ],
                )
        ]),
      ),
    );
  }
}
