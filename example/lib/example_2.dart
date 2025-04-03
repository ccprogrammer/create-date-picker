import 'dart:developer';

import 'package:create_date_picker/create_date_picker.dart';
import 'package:intl/intl.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..forward();

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  );

  ViewState _currentViewState = ViewState.date;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _changeViewState(ViewState newState) {
    if (_currentViewState != newState) {
      _animationController.reverse().then((_) {
        setState(() {
          _currentViewState = newState;
        });
        _animationController.forward();
      });
    }
  }

  Widget _createDatePickerBuilder(
    DateTime selectedDate,
    ViewState viewState,
    Widget leftArrow,
    Widget rightArrow,
    Widget popupSelectedDate,
    Widget dateViewButton,
    Widget monthViewButton,
    Widget yearViewButton,
    Widget weekday,
    Widget dateMonthYear,
    Widget dateGrid,
    Widget monthGrid,
    Widget yearGrid,
  ) {
    return Card(
      margin: EdgeInsets.all(20),
      color: Color(0xffF5F5F5),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftArrow,
                Row(
                  children: [
                    dateViewButton,
                    SizedBox(width: 10),
                    monthViewButton,
                    SizedBox(width: 10),
                    yearViewButton,
                  ],
                ),
                rightArrow,
              ],
            ),
            SizedBox(height: 20),

            FadeTransition(
              opacity: _fadeAnimation,
              child: Stack(
                children: [
                  if (_currentViewState == ViewState.date)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [weekday, SizedBox(height: 10), dateGrid],
                    ),
                  if (_currentViewState == ViewState.month) monthGrid,
                  if (_currentViewState == ViewState.year) yearGrid,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leftArrowBuilder(previous) => IconButton(
    onPressed: previous,
    icon: Icon(Icons.chevron_left),
    color: Colors.black,
    iconSize: 24,
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(CircleBorder()),
      shadowColor: WidgetStateProperty.all(Colors.black),
      elevation: WidgetStateProperty.all(0.5),
    ),
  );

  Widget _rightArrowBuilder(next) => IconButton(
    onPressed: next,
    icon: Icon(Icons.chevron_right),
    color: Colors.black,
    iconSize: 24,
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(CircleBorder()),
      shadowColor: WidgetStateProperty.all(Colors.black),
      elevation: WidgetStateProperty.all(0.5),
    ),
  );

  Widget _popupSelectedDateBuilder(selectedDate) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        DateFormat.yMEd().format(selectedDate),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(width: 5),
      const Icon(Icons.arrow_drop_down),
    ],
  );

  Widget _dateViewButtonBuilder(
    Function() selectDateView,
    DateTime selectedDate,
    bool isSelected,
  ) => GestureDetector(
    onTap: selectDateView,
    child: Card(
      color: isSelected ? Color(0xff0047FF) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
        child: Row(
          children: [
            Text(
              DateFormat.d().format(selectedDate),
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: isSelected ? Colors.white : Color(0xff0047FF),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _monthViewButtonBuilder(
    Function() selectMonthView,
    DateTime selectedDate,
    bool isSelected,
  ) => GestureDetector(
    onTap: selectMonthView,
    child: Card(
      color: isSelected ? Color(0xff0047FF) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
        child: Row(
          children: [
            Text(
              DateFormat.MMM().format(selectedDate),
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: isSelected ? Colors.white : Color(0xff0047FF),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _yearViewButtonBuilder(
    Function() selectYearView,
    DateTime selectedDate,
    bool isSelected,
  ) => GestureDetector(
    onTap: selectYearView,
    child: Card(
      color: isSelected ? Color(0xff0047FF) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
        child: Row(
          children: [
            Text(
              DateFormat.y().format(selectedDate),
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: isSelected ? Colors.white : Color(0xff0047FF),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _weekdayCellBuilder(String day, bool isToday) => Container(
    decoration:
        isToday
            ? BoxDecoration(shape: BoxShape.circle, color: Color(0xff0047FF))
            : null,
    padding: const EdgeInsets.all(12),
    child: Center(
      child: Text(
        day.substring(0, 2),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isToday ? Colors.white : Colors.black,
        ),
      ),
    ),
  );

  Widget _dateCellBuilder(
    selectdate,
    isSelected,
    isInTheCurrentMonth,
    isAvailable,
    day,
  ) => GestureDetector(
    onTap: selectdate,
    child: Card(
      color:
          isSelected
              ? Color(0xff0047FF)
              : isInTheCurrentMonth
              ? Colors.white
              : Color(0xffF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: isInTheCurrentMonth ? 0.5 : 0,
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            color:
                isInTheCurrentMonth
                    ? (isSelected
                        ? Colors.white
                        : isAvailable
                        ? Colors.black
                        : Colors.red)
                    : Colors.grey,
          ),
        ),
      ),
    ),
  );

  Widget _monthCellBuilder(selectMonth, month, isSelected, isAvailable) =>
      GestureDetector(
        onTap: selectMonth,
        child: Card(
          color: isSelected ? Color(0xff0047FF) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0.5,
          child: Center(
            child: Text(
              month.substring(0, 3),
              style: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : isAvailable
                        ? Colors.black
                        : Colors.red,
              ),
            ),
          ),
        ),
      );

  Widget _yearCellBuilder(selectYear, year, isSelected, isAvailable) =>
      GestureDetector(
        onTap: selectYear,
        child: Card(
          color: isSelected ? Color(0xff0047FF) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0.5,
          child: Center(
            child: Text(
              '$year',
              style: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : isAvailable
                        ? Colors.black
                        : Colors.red,
              ),
            ),
          ),
        ),
      );

  final List<DateTime> restrictedDates = [
    DateTime(2025, 4, 5),
    DateTime(2025, 4, 11),
  ];

  final List<String> weekLabels = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final List<String> monthLabels = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Designed by: Roma Videnov', style: TextStyle(fontSize: 16)),
        CreateDatePicker(
          width: 450,
          initialViewState: ViewState.date,
          initialDate: DateTime(2027, 6, 2),
          minDateTime: DateTime(2024, 5, 1),
          maxDateTime: DateTime(2029, 5, 1),
          restrictedDates: restrictedDates,
          weekLabels: weekLabels,
          monthLabels: monthLabels,
          leftArrowBuilder: _leftArrowBuilder,
          rightArrowBuilder: _rightArrowBuilder,
          popupSelectedDateBuilder: _popupSelectedDateBuilder,
          dateViewButtonBuilder: _dateViewButtonBuilder,
          monthViewButtonBuilder: _monthViewButtonBuilder,
          yearViewButtonBuilder: _yearViewButtonBuilder,
          weekdayCellBuilder: _weekdayCellBuilder,
          dateCellBuilder: _dateCellBuilder,
          monthCellBuilder: _monthCellBuilder,
          yearCellBuilder: _yearCellBuilder,
          builder: _createDatePickerBuilder,
          onViewStateChanged: _changeViewState,
          onSelectedDateChanged: (date) {},
        ),
      ],
    );
  }
}
