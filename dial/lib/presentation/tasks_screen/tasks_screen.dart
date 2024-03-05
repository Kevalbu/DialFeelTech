import 'package:dial/core/app_export.dart';

import 'controller/tasks_screen_controller.dart';

class TaskScreen extends GetWidget<TaskScreenController> {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      AppString.dial,
      style: DL.styleDL(
          fontSize: (50),
          fontWeight: FontWeight.bold,
          fontColor: ColorConstant.primaryBlue),
    ));
  }
}
