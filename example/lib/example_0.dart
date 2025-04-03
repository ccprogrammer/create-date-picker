import 'package:create_date_picker/create_date_picker.dart';

class Example0 extends StatelessWidget {
  const Example0({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Default',
          style: TextStyle(fontSize: 16),
        ),
        CreateDatePicker(
          width: 450,
          elevation: 3,
          popupMenuOffset: Offset(20, 5),
          onSelectedDateChanged: (date) {},
        ),
      ],
    );
  }
}
