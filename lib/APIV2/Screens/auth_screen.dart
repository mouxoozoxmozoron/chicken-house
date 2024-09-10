// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:chicken_house/APIV2/Requests/auth_request.dart';
import 'package:chicken_house/APIV2/Utils/Widgets/toasts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoginprocess = false;
  bool isNotauthenticated = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Correctly use `this` with `SingleTickerProviderStateMixin`
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 13, 154, 219),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            SizedBox(height: 20),
                            Text(
                              'Welcome to MKSB',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Welcome to MKSB Data Collection App',
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
                    const SizedBox(height: 20),

                    if (!isNotauthenticated) ...[
                      // Grid of cards or icon buttons
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final items = [
                            {'text': 'Cork', 'icon': Icons.car_crash},
                            {'text': 'Hen', 'icon': Icons.pets},
                            {'text': 'Chick', 'icon': Icons.child_care},
                            {'text': 'Eggs', 'icon': Icons.egg},
                          ];
                          final item = items[index];

                          return InkWell(
                            onTap: () {
                              // Handle card tap
                              print('${item['text']} tapped');
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 4,
                              child: SizedBox(
                                height: 100, // Customizable height
                                width: MediaQuery.of(context).size.width / 2 -
                                    15, // Full width, adjusted for spacing
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(item['icon'] as IconData,
                                          size: 30, color: Colors.blue),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item['text'] as String,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],

                    if (isNotauthenticated)
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your Email',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 20),
                    if (isNotauthenticated)
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your Password',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 20),
                    if (isNotauthenticated)
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoginprocess = true;
                          });
                          if (_formKey.currentState?.validate() ?? false) {
                            successToast('Logging in...');
                            String result = await LoginRequest.login(
                              context,
                              _emailController.text,
                              _passwordController.text,
                            );

                            if (result == 'success') {
                              setState(() {
                                isNotauthenticated = false;
                                isLoginprocess = false;
                                isNotauthenticated = false;
                              });
                            } else {
                              setState(() {
                                isLoginprocess = false;
                                isNotauthenticated = true;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text(result),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            setState(() {
                              isLoginprocess = false;
                            });
                          }
                        },
                        child: isLoginprocess
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              )
                            : const Text('Continue'),
                      ),

                    const SizedBox(height: 20),
                    // Additional UI elements
                    Container(
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'Today\'s Data',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    isLoginprocess
                        ? Center(
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 50.0,
                              controller: _controller,
                            ),
                          )
                        : Column(
                            children: List.generate(3, (index) {
                              return SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(180, 96, 194, 227),
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
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.notifications,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Card ${index + 1}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Card ${index + 1} Details',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            // const SizedBox(height: 40),
                          ),
                  ]),
            ),
          ),
        ));
  }
}
