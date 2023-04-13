import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewPatientButton extends StatefulWidget {
  final VoidCallback onPressed;
  const NewPatientButton({required this.onPressed});

  @override
  State<NewPatientButton> createState() => _NewPatientButtonState();
}

class _NewPatientButtonState extends State<NewPatientButton> {
  Color backgroundColor = const Color(0xff0085FF);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 30),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            backgroundColor = Theme.of(context).hoverColor;
          });
        },
        onExit: (event) {
          setState(() {
            backgroundColor = Theme.of(context).primaryColor;
          });
        },
        child: GestureDetector(
          onTap: () {
            widget.onPressed();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: backgroundColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 16.0,
                    offset: Offset(5, 6),
                    color: Color.fromARGB(75, 0, 0, 0),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FontAwesomeIcons.plus, color: Colors.white),
                const SizedBox(
                  width: 15.0,
                ),
                Text('New Patient',
                    style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
