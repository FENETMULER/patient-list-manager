import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main_action_button.dart';
import '../cancel_button.dart';
import '../../models/patient.dart';
import './delete_alert.dart';

class PatientDetails extends StatelessWidget {
  final Patient patient;
  final scrollController = ScrollController();

  String getFormattedDateAndTime(DateTime date) {
    var format = DateFormat('MMMM d, yyyy \'at\' h:mm a');
    var formattedDate = format.format(date
        .toLocal()); // converting date to local time zone since date is stored in UTC in mongodb
    return formattedDate;
  }

  void displayDeleteAlert(context) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(objectId: patient.id!);
        });
  }

  PatientDetails({required this.patient});

  Widget detailBuilder(
      {context, required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.grey),
        ),
        SizedBox(
          width: 200.0,
          child: Text(value,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelMedium),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(35.0, 35.0, 25.0, 15.0),
          width: 800,
          height: 470,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              detailBuilder(
                                  context: context,
                                  title: 'First Name',
                                  value: patient.firstName),
                              detailBuilder(
                                context: context,
                                title: 'Last Name',
                                value: patient.lastName,
                              ),
                              detailBuilder(
                                context: context,
                                title: 'Age',
                                value: patient.age.toString(),
                              ),
                              detailBuilder(
                                context: context,
                                title: 'Sex',
                                value: patient.sex,
                              ),
                              detailBuilder(
                                context: context,
                                title: 'Registered On',
                                value: getFormattedDateAndTime(
                                    patient.registeredOn),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              detailBuilder(
                                context: context,
                                title: 'Phone Number',
                                value: patient.phoneNumber,
                              ),
                              detailBuilder(
                                  context: context,
                                  title: 'House Number',
                                  value: patient.houseNumber == ''
                                      ? '---'
                                      : patient.houseNumber!),
                              detailBuilder(
                                context: context,
                                title: 'Sub-city',
                                value: patient.subCity == ''
                                    ? '---'
                                    : patient.subCity!,
                              ),
                              detailBuilder(
                                context: context,
                                title: 'District / Woreda',
                                value: patient.district == ''
                                    ? '---'
                                    : patient.district!,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              detailBuilder(
                                  context: context,
                                  title: 'Diagnosis',
                                  value: patient.diagnosis == ''
                                      ? '---'
                                      : patient.diagnosis!),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CancelButton(),
                  const SizedBox(width: 15.0),
                  MainActionButton(
                      onPressed: () {
                        displayDeleteAlert(context);
                      },
                      title: 'DELETE',
                      backgroundColor: Theme.of(context).colorScheme.error),
                  const SizedBox(width: 25.0),
                  MainActionButton(
                      onPressed: () {},
                      title: 'UPDATE',
                      backgroundColor: Theme.of(context).primaryColor),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
