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
                    controller: controller.phoneController,
                    labelText: AppString.phoneNumber,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    keyboardType: TextInputType.phone),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    controller: controller.phone2Controller,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    labelText: AppString.phoneNumberSecondary,
                    keyboardType: TextInputType.phone),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.name,
                    controller: controller.nameController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.email,
                    controller: controller.emailController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.companyName,
                    controller: controller.companyController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.address,
                    controller: controller.addressController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.leadScore,
                    keyboardType: TextInputType.phone,
                    controller: controller.leadScoreController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.dealValue,
                    keyboardType: TextInputType.phone,
                    controller: controller.dealController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.qualification,
                    keyboardType: TextInputType.phone,
                    controller: controller.quaController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.extra,
                    controller: controller.extraController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.remarks,
                    controller: controller.remarkController),
                SizedBox(
                  height: getHeight(10),
                ),
                textFields(
                    labelText: AppString.note,
                    controller: controller.noteController),
                SizedBox(
                  height: getHeight(20),
                ),
                AppElevatedButton(
                  buttonName: AppString.save,
                  onPressed: () {
                    controller.addContact();
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget textFields(
      {required String labelText,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      required TextEditingController controller}) {
    return TextFormField(
      cursorColor: ColorConstant.primaryBlack,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
