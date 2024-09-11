// ignore_for_file: use_build_context_synchronously

import 'package:chicken_house/APIV2/Requests/save_data_request.dart';
import 'package:chicken_house/APIV2/Utils/Widgets/toasts_widgets.dart';
import 'package:flutter/material.dart';

// class SaveDatawidget extends StatefulWidget {
//   final Function(String, String) onSubmit;
//   final VoidCallback onCancel;
//   final String itemName; // Accept itemName as a parameter

//   const SaveDatawidget({
//     Key? key,
//     required this.onSubmit,
//     required this.onCancel,
//     required this.itemName, // Required parameter for itemName
//   }) : super(key: key);

//   @override
//   _savedatawidget createState() => _savedatawidget();
// }

// class _savedatawidget extends State<SaveDatawidget> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _numberController = TextEditingController();

//   bool isNotauthenticated = true;
//   bool isLoginprocess = false;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             controller: _numberController,
//             keyboardType: TextInputType.text,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'Enter Item number',
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please specify the number of items';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 onPressed: widget.onCancel,
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     setState(() {});

//                     // Call the onSubmit function passed from the parent
//                     widget.onSubmit(
//                       _numberController.text,
//                       widget.itemName, // Use widget.itemName here
//                     );

//                     // String result = await SaveData.savedata(
//                     //   context,
//                     //   _numberController.text,
//                     //   widget.itemName,
//                     // );
//                     // if (result == 'success') {
//                     //   setState(() {});
//                     //   successToast('New data added succesfully');
//                     // } else {
//                     //   showDialog(
//                     //     context: context,
//                     //     builder: (BuildContext context) {
//                     //       return AlertDialog(
//                     //         title: const Text('Error'),
//                     //         content: Text(result),
//                     //         actions: [
//                     //           TextButton(
//                     //             onPressed: () {
//                     //               Navigator.pop(context);
//                     //             },
//                     //             child: const Text('OK'),
//                     //           ),
//                     //         ],
//                     //       );
//                     //     },
//                     //   );
//                     // }
//                   }
//                 },
//                 child: isLoginprocess
//                     ? const CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                       )
//                     : const Text('Submit'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class SaveDatawidget extends StatefulWidget {
  final Future<Map<String, dynamic>> Function(String, String) onSubmit;
  final VoidCallback onCancel;
  final String itemName;

  const SaveDatawidget({
    Key? key,
    required this.onSubmit,
    required this.onCancel,
    required this.itemName,
  }) : super(key: key);

  @override
  _SaveDatawidgetState createState() => _SaveDatawidgetState();
}

class _SaveDatawidgetState extends State<SaveDatawidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  bool isLoginprocess = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _numberController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Item number',
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please specify the number of items';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: widget.onCancel,
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() {
                      isLoginprocess = true; 
                    });

                    try {
                      final result = await widget.onSubmit(
                        _numberController.text,
                        widget.itemName,
                      );

                      if (result['status'] == 'success') {
                        successToast(result['message']);
                      } else {
                        // Show error dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text(result['message']),
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
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text('An unexpected error occurred: $e'),
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
                    } finally {
                      setState(() {
                        isLoginprocess = false; 
                      });
                    }
                  }
                },
                child: isLoginprocess
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      )
                    : const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}