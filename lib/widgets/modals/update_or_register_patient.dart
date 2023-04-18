import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constrained_text_field.dart';
import '../cancel_button.dart';
import '../main_action_button.dart';
import '../../models/patient.dart';

class UpdateOrRegisterPatient extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final Function registerPatient;
  UpdateOrRegisterPatient({required this.registerPatient});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subCityController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  late String sexValue;

  String capitalize(String str) {
    // make first letter uppercase
    if (str.isEmpty) return '';
    if (str.length == 1) return str.toUpperCase();
    var lowerCaseStr = str.toLowerCase();
    var upperCaseFirstLetter = lowerCaseStr[0].toUpperCase();
    var restOfWord = lowerCaseStr.substring(1);
    return upperCaseFirstLetter + restOfWord;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3.0,
        sigmaY: 3.0,
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: 800.0,
          height: 500.0,
          padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 50.0),
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register New Patient',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 25.0),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //First Column
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedTextField(
                                label: 'First Name',
                                controller: firstNameController,
                                isMultiline: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter First Name';
                                  }

                                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                                  if (!regex.hasMatch(value) ||
                                      value.length < 3) {
                                    return 'Invalid First Name';
                                  }
                                },
                              ),
                              ConstrainedTextField(
                                label: 'Last Name',
                                controller: lastNameController,
                                isMultiline: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Last Name';
                                  }

                                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                                  if (!regex.hasMatch(value) ||
                                      value.length < 3) {
                                    return 'Invalid Last Name';
                                  }
                                },
                              ),
                              ConstrainedTextField(
                                label: 'Age',
                                controller: ageController,
                                isMultiline: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Age';
                                  }
                                  int? age = int.tryParse(value);
                                  if (age == null || age < 0 || age > 110) {
                                    return 'Invalid Age';
                                  }
                                },
                              ),
                              SizedBox(
                                width: 200.0,
                                child: DropdownButtonFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Enter Sex';
                                    }
                                  },
                                  hint: Text('Sex',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.black)),
                                  onChanged: (value) {
                                    sexValue = value!;
                                  },
                                  alignment: Alignment.center,
                                  items: [
                                    DropdownMenuItem(
                                        value: 'Male',
                                        child: Text(
                                          'Male',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(color: Colors.black),
                                        )),
                                    DropdownMenuItem(
                                      value: 'Female',
                                      child: Text(
                                        'Female',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          //Second Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ConstrainedTextField(
                                  label: 'Phone Number',
                                  controller: phoneNumberController,
                                  isMultiline: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Phone Number';
                                    }

                                    int? number = int.tryParse(value);
                                    if (number == null ||
                                        value.length < 10 ||
                                        value.length > 10) {
                                      return 'Invalid Phone Number';
                                    }
                                  }),
                              ConstrainedTextField(
                                label: 'House Number',
                                controller: houseNumberController,
                                isMultiline: false,
                              ),
                              ConstrainedTextField(
                                label: 'District / Woreda',
                                controller: districtController,
                                isMultiline: false,
                              ),
                              ConstrainedTextField(
                                label: 'Sub-city',
                                controller: subCityController,
                                isMultiline: false,
                              )
                            ],
                          ),
                          //Third Column
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ConstrainedTextField(
                                label: 'Diagnosis',
                                controller: diagnosisController,
                                isMultiline: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CancelButton(),
                      const SizedBox(width: 25.0),
                      MainActionButton(
                        onPressed: () {
                          var isFormValid = _formKey.currentState!.validate();
                          if (isFormValid) {
                            Patient newPatient = Patient(
                              firstName: capitalize(firstNameController.text),
                              lastName: capitalize(lastNameController.text),
                              age: int.parse(ageController.text),
                              sex: sexValue,
                              phoneNumber: phoneNumberController.text,
                              houseNumber: houseNumberController.text,
                              district: districtController.text,
                              subCity: capitalize(subCityController.text),
                              diagnosis: diagnosisController
                                  .text, // didn't make uppercase
                              registeredOn: DateTime.now(),
                            );

                            registerPatient(newPatient);
                          }
                        },
                        title: 'REGISTER',
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
