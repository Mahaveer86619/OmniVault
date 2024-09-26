import 'package:flutter/material.dart';
import 'package:omni_vault/core/theme/pallete.dart';
import 'package:pinput/pinput.dart';
import 'package:country_picker/country_picker.dart';

class MyFormTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final String label;
  final bool obscureText;
  final String? Function(String?) validator;
  final String? initialText;

  const MyFormTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.keyboardAction,
    this.obscureText = false,
    required this.validator,
    this.initialText,
  });

  @override
  State<MyFormTextField> createState() => _MyFormTextFieldState();
}

class _MyFormTextFieldState extends State<MyFormTextField> {
  bool _visibility = true; // For password field

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialText,
      validator: widget.validator,
      obscureText: widget.obscureText ? _visibility : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = value;
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _visibility ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  setState(() {
                    _visibility = !_visibility;
                  });
                },
              )
            : null,
      ),
    );
  }
}

class MyBigTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final int? lines;
  final String? initialValue;

  const MyBigTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.lines,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: lines,
      minLines: lines,
      autocorrect: true,
      onChanged: (value) {
        controller.text = value;
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MySearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? initialValue;

  const MySearchBar({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      autocorrect: true,
      onChanged: (value) {
        controller.text = value;
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Pallete.appBarColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MyPhoneField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction keyboardAction;
  final String label;

  const MyPhoneField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.keyboardAction,
  });

  @override
  State<MyPhoneField> createState() => _MyPhoneFieldState();
}

class _MyPhoneFieldState extends State<MyPhoneField> {
  Country selectedCountry = Country(
    phoneCode: "+91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextField(
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      maxLines: 1,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = "${selectedCountry.phoneCode}$value";
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                countryListTheme: const CountryListThemeData(
                  bottomSheetHeight: 550,
                ),
                onSelect: (value) {
                  selectedCountry = value;
                },
              );
            },
            child: Text(
              "${selectedCountry.flagEmoji} ${selectedCountry.phoneCode}",
              style: TextStyle(
                fontSize: 18,
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PinCodeField extends StatelessWidget {
  final TextEditingController otpController;
  const PinCodeField({
    super.key,
    required this.otpController,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Pinput(
      length: 6,
      showCursor: true,
      defaultPinTheme: PinTheme(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.colorScheme.onBackground,
          ),
        ),
        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
      ),
      controller: otpController,
    );
  }
}
