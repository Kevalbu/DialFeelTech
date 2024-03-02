import '../core/app_export.dart';

class CustomArrowTextForm extends StatelessWidget {
  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextStyle? fontStyle;
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
  String? title;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;

  bool? readOnly;

  Function()? onTap;

  Function(String)? onChanged;
  CustomArrowTextForm(
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
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.readOnly,
      this.onTap,
      this.onChanged,
      this.title,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? "",
            style: DL.style(16,
                fontWeight: FontWeight.w700,
                fontColor: ColorConstant.greyColor72)),
        Container(
          width: width ?? double.maxFinite,
          margin: margin,
          child: TextFormField(
            cursorColor: ColorConstant.greyColor72,
            controller: controller,
            readOnly: readOnly ?? false,
            onTap: onTap,
            onChanged: onChanged,
            focusNode: focusNode,
            style: fontStyle ??
                DL.style(16,
                    fontWeight: FontWeight.w500,
                    fontColor: ColorConstant.primaryBlack),
            obscureText: isObscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: _buildDecoration(),
            validator: validator,
          ),
        ),
      ],
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? AppString.selectHere,
      hintStyle:
          fontStyle ?? DL.style(14, fontColor: ColorConstant.greyColorB3),
      border: _setBorderStyle(),
      focusColor: ColorConstant.greyColorB3,
      suffixIconColor: ColorConstant.greyColorB3,
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.greyColord3)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.greyColord3)),
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.greyColord3)),

      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      contentPadding: EdgeInsets.only(top: getHeight(6), bottom: getHeight(6)),
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
          //borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.greyBack,
            width: 1,
          ),
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return;
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return ColorConstant.primaryWhite;
      default:
        return ColorConstant.transparent;
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
