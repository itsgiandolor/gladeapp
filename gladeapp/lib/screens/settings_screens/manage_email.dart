import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/top_navbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_field.dart';

class ManageEmailScreen extends StatelessWidget {
  const ManageEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(); // Add controller for email

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensure content resizes when keyboard shows
      appBar: const SubSettingsTopNavbar(title: 'Manage email'),
      body: Container(
        color: AppTheme.backgroundColor,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    vertical: 25), // Add top & bottom space
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 440,
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            _buildCurrentEmailCard(),
                            const SizedBox(height: 23),
                            _buildNewEmailCard(emailController),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildCurrentEmailCard() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 13, 28, 27),
    decoration: BoxDecoration(
      color: AppTheme.white,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current email',
          style: TextStyle(
            color: AppTheme.black,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Text(
            'username@example.com',
            style: TextStyle(
              color: AppTheme.black,
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNewEmailCard(TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 13, 28, 23),
    decoration: BoxDecoration(
      color: AppTheme.white,
      borderRadius: BorderRadius.circular(11),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New email address',
          style: TextStyle(
            color: Color.fromRGBO(30, 30, 30, 1),
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        ManageEmailInputField(
          label: 'Email',
          controller: controller,
        ),
        const SizedBox(height: 19),
        SubSettingsActionButton(
          buttonName: 'Update email',
          onPressed: () {
            debugPrint("Email updated");
          },
        ),
      ],
    ),
  );
}
