import 'package:dial/core/app_export.dart';
import 'controller/add_new_contact_screen_controller.dart';

class AddNewContactScreen extends GetWidget<AddNewContactScreenController> {
  const AddNewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeCalculate(context);

    return Scaffold(
        backgroundColor: ColorConstant.primaryWhite,
        appBar: AppBar(
          elevation: 3,
          surfaceTintColor: ColorConstant.primaryWhite,
          shadowColor: ColorConstant.greyColor72,
          backgroundColor: ColorConstant.primaryWhite,
          title: Text(
            AppString.addNewContact,
            style: DL.styleDL(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(25)),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(20),
                ),
                textFields(
                    labelText: AppString.phoneNumber,
                    keyboardType: TextInputType.phone),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(labelText: AppString.name),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(labelText: AppString.email),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(labelText: AppString.companyName),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(labelText: AppString.address),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(labelText: AppString.extra),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(labelText: AppString.remarks),
                SizedBox(
                  height: getHeight(130),
                ),
                AppElevatedButton(
                  buttonName: AppString.save,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ));
  }

  Widget textFields({required String labelText, TextInputType? keyboardType}) {
    return TextFormField(
      cursorColor: ColorConstant.primaryBlack,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: DL.styleDL(
            fontColor: ColorConstant.greyColor72, fontWeight: FontWeight.w600),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: ColorConstant.greyColorB3,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: ColorConstant.primaryBlue,
          ),
        ),
      ),
    );
  }
}
