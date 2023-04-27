import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constrained_text_field.dart';
import '../cancel_button.dart';
import '../main_action_button.dart';
import '../../models/patient.dart';
import '../../utils/ui_helpers.dart';
import 'message_modal.dart';
import '../../services/patient_services.dart';
import '../../providers/patients_providers.dart';
import '../../providers/search_query_provider.dart';
import '../../providers/search_results_provider.dart';

class UpdateOrRegisterPatient extends ConsumerStatefulWidget {
  late bool isUpdate;
  Patient? patient;
  UpdateOrRegisterPatient({super.key}) {
    isUpdate = false;
  }

  UpdateOrRegisterPatient.update({required this.patient, super.key}) {
    isUpdate = true;
  }
  @override
  ConsumerState<UpdateOrRegisterPatient> createState() =>
      _UpdateOrRegisterPatientState();
}

class _UpdateOrRegisterPatientState
    extends ConsumerState<UpdateOrRegisterPatient> {
  final _formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _houseNumberController = TextEditingController();

  final TextEditingController _districtController = TextEditingController();

  final TextEditingController _subCityController = TextEditingController();

  final TextEditingController _diagnosisController = TextEditingController();

  late String _sexValue;

  String _capitalize(String str) {
    // make first letter uppercase
    if (str.isEmpty) return '';
    if (str.length == 1) return str.toUpperCase();
    var lowerCaseStr = str.toLowerCase();
    var upperCaseFirstLetter = lowerCaseStr[0].toUpperCase();
    var restOfWord = lowerCaseStr.substring(1);
    return upperCaseFirstLetter + restOfWord;
  }

  void _registerPatient(Patient patient, context) async {
    try {
      var patientMap = {
        'firstName': patient.firstName,
        'lastName': patient.lastName,
        'age': patient.age,
        'sex': patient.sex,
        'phoneNumber': patient.phoneNumber,
        'houseNumber': patient.houseNumber,
        'district': patient.district,
        'subCity': patient.subCity,
        'diagnosis': patient.diagnosis,
        'registeredOn': patient.registeredOn,
      };
      await dbRegisterPatient(patientMap);
      ref.invalidate(recentPatientsProvider);

      // update patient list when a new patient is added
      final searchQuery = ref.read(searchQueryProvider);
      ref.read(searchResultsProvider.notifier).newSearchResults(searchQuery);

      await displayMessageModal(Operation.registered, context);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      await displayMessageModal(Operation.error, context);
    }
  }

  void _updatePatientRecord(patient, context) async {
    try {
      await dbUpdatePatient(patient);
      ref.invalidate(recentPatientsProvider);

      await displayMessageModal(Operation.updated, context);
      Navigator.of(context).popUntil((route) => route.isFirst);
      displayPatientDetailsModal(context, patient);

      // getting searchQuery and updating the search results after updating patient record.
      final searchQuery = ref.read(searchQueryProvider);
      ref.read(searchResultsProvider.notifier).newSearchResults(searchQuery);
    } catch (e) {
      // display error modal when an exception is thrown
      displayMessageModal(Operation.error, context);
    }
  }

  @override
  void initState() {
    super.initState();
    final patient = widget.patient;
    if (widget.isUpdate == true) {
      _firstNameController.text = patient!.firstName;
      _lastNameController.text = patient.lastName;
      _ageController.text = patient.age.toString();
      _sexValue = patient.sex;
      _phoneNumberController.text = patient.phoneNumber;
      _houseNumberController.text = patient.houseNumber!;
      _districtController.text = patient.district!;
      _subCityController.text = patient.subCity!;
      _diagnosisController.text = patient.diagnosis!;
    }
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
                    widget.isUpdate
                        ? 'Update Patient Record'
                        : 'Register New Patient',
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
                                controller: _firstNameController,
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
                                controller: _lastNameController,
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
                                controller: _ageController,
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
                                  value: widget
                                          .isUpdate // default value of DropdownButtonFormField, even if it is set to null DropdownMenuItems can change that value when selected.
                                      ? widget.patient!.sex
                                      : null,
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
                                    _sexValue = value!;
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
                                  controller: _phoneNumberController,
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
                                label: 'House Number (optional)',
                                controller: _houseNumberController,
                                isMultiline: false,
                              ),
                              ConstrainedTextField(
                                label: 'District / Woreda (optional)',
                                controller: _districtController,
                                isMultiline: false,
                              ),
                              ConstrainedTextField(
                                label: 'Sub-city (optional)',
                                controller: _subCityController,
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
                                label: 'Diagnosis (optional)',
                                controller: _diagnosisController,
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
                              firstName: _capitalize(_firstNameController.text),
                              lastName: _capitalize(_lastNameController.text),
                              age: int.parse(_ageController.text),
                              sex: _sexValue,
                              phoneNumber: _phoneNumberController.text,
                              houseNumber: _houseNumberController.text,
                              district: _districtController.text,
                              subCity: _capitalize(_subCityController.text),
                              diagnosis: _diagnosisController
                                  .text, // didn't make uppercase
                              registeredOn: widget.isUpdate
                                  ? widget.patient!.registeredOn
                                  : DateTime.now(),
                              id: widget.isUpdate ? widget.patient!.id : null,
                            );

                            widget.isUpdate
                                ? _updatePatientRecord(newPatient, context)
                                : _registerPatient(newPatient, context);
                          }
                        },
                        title: widget.isUpdate ? 'UPDATE' : 'REGISTER',
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
