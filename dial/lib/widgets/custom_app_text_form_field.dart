import '../core/app_export.dart';

class CustomAppTextFormField extends StatelessWidget {
  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextStyle? fontStyle;
  TextStyle? labelStyle;
  TextStyle? hintFontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;

  TextInputAction? textInputAction;

  TextInputType? textInputType;

  int? maxLines;

  String? hintText;
  String? labelText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;

  bool? readOnly;

  Function()? onTap;

  Function(String)? onChanged;
  CustomAppTextFormField(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.labelText,
      this.labelStyle,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.readOnly,
      this.onTap,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        controller: controller,
        cursorColor: ColorConstant.primaryBlue,
        readOnly: readOnly ?? false,
        onTap: onTap,
        onChanged: onChanged,
        focusNode: focusNode,
        style: fontStyle ?? DL.style(18),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: fontStyle ?? DL.style(14),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix, labelText: labelText ?? "",
      labelStyle: labelStyle ?? DL.style(14),
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),

      isDense: true,
      // contentPadding: _setPadding(),
    );
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.RoundedBorder18:
        return BorderRadius.circular(
          getWidth(
            18.00,
          ),
        );

      default:
        return BorderRadius.circular(
          getWidth(
            12.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.primaryBlue,
            width: 1,
          ),
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.primaryBlue,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return ColorConstant.primaryWhite;
      default:
        return ColorConstant.primaryWhite;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  // _setPadding() {
  //   switch (padding) {
  //     case TextFormFieldPadding.PaddingT13:
  //       return getPadding(
  //         left: 12,
  //         top: 13,
  //         bottom: 13,
  //       );
  //     default:
  //       return getPadding(
  //         left: 12,
  //         top: 16,
  //         right: 12,
  //         bottom: 16,
  //       );
  //   }
  // }
}

enum TextFormFieldShape {
  RoundedBorder12,
  RoundedBorder18,
}

enum TextFormFieldPadding {
  PaddingT14,
  PaddingT13,
}

enum TextFormFieldVariant {
  None,
  OutlineGray200,
  White,
}

enum TextFormFieldFontStyle {
  GilroyMedium16Bluegray40001,
  GilroyMedium16,
  txtGilroyMedium
}
