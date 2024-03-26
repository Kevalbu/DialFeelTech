import '../core/app_export.dart';

class AppElevatedButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onPressed;
  final Color? textColor;
  final Color? buttonColor;
  final Color? buttonShadowColor;
  final FontWeight? fontWeight;
  final double? radius;
  final double? width;
  final IconData? icon;
  final bool? isLoading;
  final double? fontSize;
  final bool? showTextIcon;
  final bool shadow;
  bool? hasGradient = true;
  final String? textIcon;
  final Color? borderColor;

  AppElevatedButton(
      {Key? key,
      required this.buttonName,
      required this.onPressed,
      this.textColor,
      this.textIcon,
      this.width,
      this.borderColor,
      this.fontWeight,
      this.fontSize,
      this.buttonColor,
      this.icon,
      this.radius,
      this.showTextIcon,
      this.shadow = false,
      this.hasGradient = true,
      this.isLoading = false,
      this.buttonShadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: getHeight(40),
      decoration: BoxDecoration(
        border: hasGradient ?? false
            ? null
            : Border.all(
                color: borderColor ?? ColorConstant.primaryBlue,
                width: getHeight(1)),
        color: buttonColor ?? ColorConstant.primaryBlue,
        boxShadow: shadow
            ? [
                BoxShadow(
                    blurRadius: 2.0,
                    offset: const Offset(0.5, 2),
                    color: buttonShadowColor ?? ColorConstant.greyColor72),
              ]
            : null,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          disabledForegroundColor: buttonColor ?? ColorConstant.primaryBlue,
          disabledBackgroundColor: buttonColor ?? ColorConstant.primaryBlue,
          foregroundColor: buttonColor ?? ColorConstant.primaryBlue,
          surfaceTintColor: buttonColor ?? ColorConstant.primaryBlue,
          backgroundColor: buttonColor ?? ColorConstant.primaryBlue,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        child: !isLoading!
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showTextIcon ?? false
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            icon,
                            color: ColorConstant.primaryWhite,
                          ))
                      : const SizedBox(),
                  Text(
                    buttonName.toString(),
                    style: DL.styleDL(
                      fontSize: getFontSize(fontSize ?? 12),
                      fontColor: textColor ?? ColorConstant.primaryWhite,
                      fontWeight: fontWeight ?? FontWeight.w500,
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: getHeight(20),
                width: getHeight(20),
                child: const CircularProgressIndicator(
                  color: ColorConstant.primaryWhite,
                  strokeWidth: 3,
                )),
      ),
    );
  }
}
