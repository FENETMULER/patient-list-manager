import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './constrained_text_field.dart';
import './cancel_button.dart';
import './main_action_button.dart';

class UpdateOrRegisterPatient extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  UpdateOrRegisterPatient({super.key});

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
                                isMultiline: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter First Name';
                                  }

                                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                                  if (!regex.hasMatch(value)) {
                                    return 'Invalid First Name';
                                  }
                                },
                              ),
                              ConstrainedTextField(
                                label: 'Last Name',
                                isMultiline: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Last Name';
                                  }

                                  RegExp regex = RegExp(r'^[a-zA-Z]+$');
                                  if (!regex.hasMatch(value)) {
                                    return 'Invalid Last Name';
                                  }
                                },
                              ),
                              ConstrainedTextField(
                                label: 'Age',
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
                                  onChanged: (value) {},
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
                                  isMultiline: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Phone Number';
                                    }

                                    int? number = int.tryParse(value);
                                    if (number == null || value.length < 10) {
                                      return 'Invalid Phone Number';
                                    }
                                  }),
                              ConstrainedTextField(
                                  label: 'House Number',
                                  isMultiline: false,
                                  validator: (value) {}),
                              ConstrainedTextField(
                                  label: 'Woreda',
                                  isMultiline: false,
                                  validator: (value) {}),
                              ConstrainedTextField(
                                  label: 'Sub-city',
                                  isMultiline: false,
                                  validator: (value) {})
                            ],
                          ),
                          //Third Column
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ConstrainedTextField(
                                  label: 'Diagnosis',
                                  isMultiline: true,
                                  validator: (value) {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CancelButton(),
                      const SizedBox(width: 25.0),
                      MainActionButton(
                        onPressed: () {
                          _formKey.currentState!.validate();
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
