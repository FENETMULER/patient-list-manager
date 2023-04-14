import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './constrained_text_field.dart';
import './cancel_button.dart';
import './main_action_button.dart';

class UpdateOrRegisterPatient extends StatelessWidget {
  const UpdateOrRegisterPatient({super.key});

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
                            label: 'Full Name', isMultiline: false),
                        ConstrainedTextField(label: 'Age', isMultiline: false),
                        DropdownMenu(
                          textStyle: Theme.of(context).textTheme.labelMedium,
                          hintText: 'Sex',
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                              value: 'Male',
                              label: 'Male',
                              trailingIcon: Icon(FontAwesomeIcons.person,
                                  color: Colors.grey[700]),
                            ),
                            DropdownMenuEntry(
                              value: 'Female',
                              label: 'Female',
                              trailingIcon: Icon(FontAwesomeIcons.personDress,
                                  color: Colors.grey[700]),
                            ),
                          ],
                        )
                      ],
                    ),
                    //Second Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        ConstrainedTextField(
                            label: 'Phone Number', isMultiline: false),
                        ConstrainedTextField(
                            label: 'House Number', isMultiline: false),
                        ConstrainedTextField(
                            label: 'Woreda', isMultiline: false),
                        ConstrainedTextField(
                            label: 'Sub-city', isMultiline: false)
                      ],
                    ),
                    //Third Column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ConstrainedTextField(
                            label: 'Diagnosis', isMultiline: true),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CancelButton(),
                  const SizedBox(width: 25.0),
                  MainActionButton(
                    onPressed: () {},
                    title: 'REGISTER',
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
