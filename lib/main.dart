// ignore_for_file: avoid_unnecessary_containers

import 'package:chicken_house/APIV2/Utils/Widgets/toasts_widgets.dart';
import 'package:chicken_house/APIV2/Utils/routes/routes_configuration.dart';
import 'package:chicken_house/APIV2/components/bottom_sheet.dart';
import 'package:chicken_house/APIV2/components/box_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      initialRoute:
          RoutesClass.getHomeRoute(), // Specify the initial route if needed
      getPages: RoutesClass.routes, // Use the routes configuration
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcome to MKSC Data Collection App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Export all Modules Summary Report',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(220, 200, 19, 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      // ignore: prefer_const_constructors
                      child: Center(
                          child: const Text(
                        'Export PDF',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomBox(
                                icon: Icons.bike_scooter_rounded,
                                text: 'Chicken House',
                                color: Colors.lightBlue,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled:
                                        true, // Adjusts for soft keyboard
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    builder: (context) =>
                                        const BottomSheetContent(),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomBox(
                                icon: Icons.notifications,
                                text: 'Box 2',
                                color: Colors.lightBlue,
                                onTap: () {
                                  successToast('Chicken button clicked');
                                  print('Chicken button clicked');
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomBox(
                                icon: Icons.notifications,
                                text: 'Box 3',
                                color: Colors.lightBlue,
                                onTap: () {
                                  successToast('Chicken button clicked');
                                  print('Chicken button clicked');
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10), // Add spacing between rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomBox(
                                icon: Icons.email,
                                text: 'Box 4',
                                color: Colors.lightBlue,
                                onTap: () {
                                  successToast('Chicken button clicked');
                                  print('Chicken button clicked');
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomBox(
                                icon: Icons.notifications,
                                text: 'Box 5',
                                color: Colors.lightBlue,
                                onTap: () {
                                  successToast('Chicken button clicked');
                                  print('Chicken button clicked');
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomBox(
                                icon: Icons.notifications,
                                text: 'Box 6',
                                color: Colors.lightBlue,
                                onTap: () {
                                  successToast('Chicken button clicked');
                                  print('Chicken button clicked');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
