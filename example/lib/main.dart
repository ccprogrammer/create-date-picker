import 'package:create_date_picker/create_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:example/example_0.dart';
import 'package:example/example_2.dart';
import 'package:example/example_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Your Own Datepicker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Example0(), Example1(), Example2(), Example3()],
            ),
          ],
        ),
      ),
    );
  }
}

class Example1 extends StatefulWidget {
  const Example1({super.key});

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1>
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

  void _onSelectedDateChanged(DateTime date) {}

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
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff1E2028),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 14, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    dateViewButton,
                    SizedBox(width: 10),
                    monthViewButton,
                    SizedBox(width: 10),
                    yearViewButton,
                  ],
                ),
                Spacer(),
                leftArrow,
                SizedBox(width: 20),
                rightArrow,
              ],
            ),
          ),
          SizedBox(height: 10),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Stack(
              children: [
                if (_currentViewState == ViewState.date)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        color: Color(0xff2A2D37),
                        child: weekday,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: dateGrid,
                      ),
                    ],
                  ),
                if (_currentViewState == ViewState.month)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: monthGrid,
                  ),
                if (_currentViewState == ViewState.year)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: yearGrid,
                  ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _leftArrowBuilder(previous) => Padding(
    padding: const EdgeInsets.only(left: 10),
    child: GestureDetector(
      onTap: previous,
      child: Icon(Icons.arrow_back, size: 24, color: Colors.white),
    ),
  );

  Widget _rightArrowBuilder(next) => Padding(
    padding: const EdgeInsets.only(right: 10),
    child: GestureDetector(
      onTap: next,
      child: Icon(Icons.arrow_forward, size: 24, color: Colors.white),
    ),
  );

  Widget _dateViewButtonBuilder(
    Function() selectDateView,
    DateTime selectedDate,
    bool isSelected,
  ) => GestureDetector(
    onTap: selectDateView,
    child: Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff929DBE),
                  height: 0,
                ),
              ),
              Text(
                DateFormat.d().format(selectedDate),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(width: 5),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: isSelected ? Colors.blue : Colors.white,
          ),
        ],
      ),
    ),
  );

  Widget _monthViewButtonBuilder(
    Function() selectMonthView,
    DateTime selectedDate,
    bool isSelected,
  ) => GestureDetector(
    onTap: selectMonthView,
    child: Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Month',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff929DBE),
                  height: 0,
                ),
              ),
              Text(
                DateFormat.MMM().format(selectedDate),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(width: 5),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: isSelected ? Colors.blue : Colors.white,
          ),
        ],
      ),
    ),
  );

  Widget _yearViewButtonBuilder(
    Function() selectYearView,
    DateTime selectedDate,
    bool isSelected,
  ) => InkWell(
    onTap: selectYearView,
    child: Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Year',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff929DBE),
                  height: 0,
                ),
              ),
              Text(
                DateFormat.y().format(selectedDate),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(width: 5),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: isSelected ? Colors.blue : Colors.white,
          ),
        ],
      ),
    ),
  );

  Widget _weekdayCellBuilder(String day, bool isToday) => Center(
    child: Text(
      day.substring(0, 2),
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
      color: isSelected ? Colors.blue : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
                        ? Colors.white
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
          color: isSelected ? Colors.blue : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          child: Center(
            child: Text(
              month.substring(0, 3),
              style: TextStyle(color: isAvailable ? Colors.white : Colors.red),
            ),
          ),
        ),
      );

  Widget _yearCellBuilder(selectYear, year, isSelected, isAvailable) =>
      GestureDetector(
        onTap: selectYear,
        child: Card(
          color: isSelected ? Colors.blue : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          child: Center(
            child: Text(
              '$year',
              style: TextStyle(color: isAvailable ? Colors.white : Colors.red),
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
        Text('Designed by: Mark Vasyliev', style: TextStyle(fontSize: 16)),
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
          dateViewButtonBuilder: _dateViewButtonBuilder,
          monthViewButtonBuilder: _monthViewButtonBuilder,
          yearViewButtonBuilder: _yearViewButtonBuilder,
          weekdayCellBuilder: _weekdayCellBuilder,
          dateCellBuilder: _dateCellBuilder,
          monthCellBuilder: _monthCellBuilder,
          yearCellBuilder: _yearCellBuilder,
          onViewStateChanged: _changeViewState,
          onSelectedDateChanged: _onSelectedDateChanged,
          builder: _createDatePickerBuilder,
        ),
      ],
    );
  }
}
