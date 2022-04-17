import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _errorColor = Color(0xFFFF0000);

class WalletTextForm extends StatefulWidget {
  const WalletTextForm({
    Key? key,
    required this.label,
    this.controller,
    this.inputType,
    this.inputAction,
    this.inputFormatters,
    this.validator,
    this.onTextFormSubmitted,
    this.obscureText = false, this.enableSuggestions = true, this.autocorrect = true,
  }) : super(key: key);

  WalletTextForm.numeric({
    Key? key,
    required this.label,
    this.controller,
    this.inputAction,
    this.validator,
    this.onTextFormSubmitted,
    this.obscureText = false, this.enableSuggestions = true, this.autocorrect = true,
  })  : inputType = const TextInputType.numberWithOptions(signed: true),
        inputFormatters = [FilteringTextInputFormatter.digitsOnly],
        super(key: key);

  WalletTextForm.decimal({
    Key? key,
    required this.label,
    this.controller,
    this.inputAction,
    this.validator,
    this.onTextFormSubmitted,
    this.obscureText = false, this.enableSuggestions = true, this.autocorrect = true,
  })  : inputType = const TextInputType.numberWithOptions(
    signed: true,
  ),
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,8})')),
        ],
        super(key: key);

  const WalletTextForm.password({
    Key? key,
    required this.label,
    this.controller,
    this.inputAction,
    this.validator,
    this.inputType,
    this.inputFormatters,
    this.onTextFormSubmitted,
    this.obscureText = true,
    this.enableSuggestions = false,
    this.autocorrect = false,
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onTextFormSubmitted;

  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  @override
  _WalletTextFormState createState() => _WalletTextFormState();
}

class _WalletTextFormState extends State<WalletTextForm> {
  final _focus = FocusNode();
  bool _isValidateText = true;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focus,
      keyboardType: widget.inputType,
      textInputAction: widget.inputAction,
      onFieldSubmitted: widget.onTextFormSubmitted,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      style: TextStyle(
        color: _isValidateText ? Colors.black : _errorColor,
        fontSize: 16.0,
        fontFamily: 'AvenirNext-Regular',
      ),
      validator: (text) {
        if (widget.validator != null) {
          final errorText = widget.validator!(text);
          setState(() {
            _isValidateText = errorText == null;
          });
          return errorText;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: _isValidateText
              ? _focus.hasFocus
              ? Colors.orange
              : Colors.grey
              : _errorColor,
          fontSize: 16.0,
          fontFamily: 'AvenirNext-Regular',
        ),
        errorStyle: const TextStyle(
          color: _errorColor,
          fontSize: 12.0,
          fontFamily: 'AvenirNext-Regular',
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: _errorColor),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: _errorColor),
        ),
      ),
    );
  }
}
