import 'dart:developer';

import 'package:create_date_picker/create_date_picker.dart';
import 'package:intl/intl.dart';

class Example3 extends StatefulWidget {
  const Example3({super.key});

  @override
  State<Example3> createState() => _Example3State();
}

class _Example3State extends State<Example3>
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
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.close),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    elevation: WidgetStatePropertyAll(1),
                    shadowColor: WidgetStatePropertyAll(Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.orange),
                    elevation: WidgetStatePropertyAll(1),
                  ),
                  child: Text('Accept', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Divider(height: 40, color: Colors.grey.withOpacity(0.5)),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                popupSelectedDate,
                Spacer(),
                leftArrow,
                SizedBox(width: 20),
                rightArrow,
              ],
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

  Widget _popupSelectedDateBuilder(selectedDate) => Card(
    color: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat.yMEd().format(selectedDate),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_drop_down, color: Colors.black),
        ],
      ),
    ),
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
    padding: const EdgeInsets.all(12),
    child: Center(
      child: Text(
        day.substring(0, 2),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
              ? Colors.orange
              : isInTheCurrentMonth && isAvailable
              ? Colors.grey.withOpacity(0.1)
              : Color(0xffF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      elevation: 0,
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
                    : Colors.black38,
          ),
        ),
      ),
    ),
  );

  Widget _monthCellBuilder(
    selectMonth,
    String month,
    isSelected,
    isAvailable,
  ) => GestureDetector(
    onTap: selectMonth,
    child: Card(
      color: isSelected ? Colors.orange : Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      elevation: 0,
      child: Center(
        child: Text(
          month.substring(0, 2),
          style: TextStyle(
            color:
                isAvailable
                    ? isSelected
                        ? Colors.white
                        : Colors.black
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
          color:
              isSelected
                  ? Colors.orange
                  : isAvailable
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
          elevation: 0,
          child: Center(
            child: Text(
              '$year',
              style: TextStyle(
                color:
                    isAvailable
                        ? isSelected
                            ? Colors.white
                            : Colors.black
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
        Text('Designed by: Sardor A', style: TextStyle(fontSize: 16)),
        CreateDatePicker(
          width: 450,
          popupMenuOffset: Offset(-10, 10),
          initialViewState: ViewState.date,
          initialDate: DateTime(2025, 6, 2),
          minDateTime: DateTime(2024, 5, 6),
          maxDateTime: DateTime(2026, 2, 21),
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
