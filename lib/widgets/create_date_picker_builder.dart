import 'package:flutter/material.dart';

/// Enum representing the different view states of the date picker.
/// - [date]: Displays the date view.
/// - [month]: Displays the month view.
/// - [year]: Displays the year view.
enum ViewState { date, month, year }

class CreateDatePicker extends StatefulWidget {
  /// A customizable date picker widget that allows users to select dates, months, or years.
  ///
  /// The `CreateDatePicker` widget provides a flexible and highly customizable date picker
  /// with support for restricted dates, minimum and maximum date constraints, and custom
  /// builders for various UI components.
  ///
  /// ### Features:
  /// - Switch between date, month, and year views.
  /// - Restrict selectable dates using `minDateTime`, `maxDateTime`, and `restrictedDates`.
  /// - Customize the appearance of the picker using builder functions.
  /// - Localize week and month labels using `weekLabels` and `monthLabels`.
  ///
  /// ### Example Usage:
  /// ```dart
  ///  CreateDatePicker(
  ///     width: 450,
  ///     initialViewState: ViewState.date,
  ///     initialDate: DateTime(2027, 6, 2),
  ///     minDateTime: DateTime(2024, 5, 1),
  ///     maxDateTime: DateTime(2029, 5, 1),
  ///     restrictedDates: restrictedDates,
  ///     weekLabels: weekLabels,
  ///     monthLabels: monthLabels,
  ///     leftArrowBuilder: _leftArrowBuilder,
  ///     rightArrowBuilder: _rightArrowBuilder,
  ///     dateViewButtonBuilder: _dateViewButtonBuilder,
  ///     monthViewButtonBuilder: _monthViewButtonBuilder,
  ///     yearViewButtonBuilder: _yearViewButtonBuilder,
  ///     weekdayCellBuilder: _weekdayCellBuilder,
  ///     dateCellBuilder: _dateCellBuilder,
  ///     monthCellBuilder: _monthCellBuilder,
  ///     yearCellBuilder: _yearCellBuilder,
  ///     onViewStateChanged: _changeViewState,
  ///     onSelectedDateChanged: _onSelectedDateChanged,
  ///     builder: _createDatePickerBuilder,
  ///  ),
  /// ```
  ///
  /// ### Notes:
  /// - Ensure that `weekLabels` contains exactly 7 items.
  /// - Ensure that `monthLabels` contains exactly 12 items.
  /// - The `initialDate` must not be before `minDateTime` or after `maxDateTime`.
  /// - The `initialDate` must not be included in `restrictedDates`.
  CreateDatePicker({
    super.key,
    this.initialViewState = ViewState.date,
    this.initialDate,
    this.minDateTime,
    this.maxDateTime,
    this.restrictedDates = const [],
    this.weekLabels = const [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ],
    this.monthLabels = const [
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
    ],
    this.width,
    this.elevation = 1,
    this.popupMenuOffset,
    this.popupMenuPosition = PopupMenuPosition.under,
    this.builder,
    this.leftArrowBuilder,
    this.rightArrowBuilder,
    this.popupSelectedDateBuilder,
    this.dateViewButtonBuilder,
    this.monthViewButtonBuilder,
    this.yearViewButtonBuilder,
    this.weekdayCellBuilder,
    this.dateCellBuilder,
    this.monthCellBuilder,
    this.yearCellBuilder,
    this.onViewStateChanged,
    required this.onSelectedDateChanged,
  }) : assert(
         initialDate == null ||
             (minDateTime == null || !initialDate.isBefore(minDateTime)),
         'initialDate cannot be before minDateTime',
       ),
       assert(
         initialDate == null ||
             (maxDateTime == null || !initialDate.isAfter(maxDateTime)),
         'initialDate cannot be after maxDateTime',
       ),
       assert(
         initialDate == null ||
             !restrictedDates.any((restrictedDate) {
               return initialDate.year == restrictedDate.year &&
                   initialDate.month == restrictedDate.month &&
                   initialDate.day == restrictedDate.day;
             }),
         'initialDate cannot be included in restricted dates',
       ),
       assert(
         !restrictedDates.any((restrictedDate) {
           return DateTime.now().year == restrictedDate.year &&
               DateTime.now().month == restrictedDate.month &&
               DateTime.now().day == restrictedDate.day;
         }),
         'initialDate cannot be included in restricted dates',
       ),
       assert((weekLabels.length == 7), 'weekLabels must contain 7 days'),
       assert((monthLabels.length == 12), 'monthLabels must contain 12 month');

  /// The initial view state of the picker (date, month, or year).
  final ViewState initialViewState;

  /// The initially selected date.
  final DateTime? initialDate;

  /// The minimum selectable date.
  final DateTime? minDateTime;

  /// The maximum selectable date.
  final DateTime? maxDateTime;

  /// A list of dates that cannot be selected.
  final List<DateTime> restrictedDates;

  /// Labels for the days of the week (e.g., Sunday, Monday).
  /// Must contain exactly 7 items.
  final List<String> weekLabels;

  /// Labels for the months of the year (e.g., January, February).
  /// Must contain exactly 12 items.
  final List<String> monthLabels;

  /// The width of the picker.
  final double? width;

  // Set the default Datepicker elevation
  final double elevation;

  /// Offset for the popup menu.
  final Offset? popupMenuOffset;

  /// Position of the popup menu (above or below the trigger).
  final PopupMenuPosition popupMenuPosition;

  /// Custom builder for the entire picker. Here you can place all the component where ever you want, and to customize it use the builder for each component.
  final Function(
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
  )?
  builder;

  /// Custom builder for the left navigation arrow.
  final Function(Function() previous)? leftArrowBuilder;

  /// Custom builder for the right navigation arrow.
  final Function(Function() next)? rightArrowBuilder;

  /// Custom builder for the popup displaying the selected date.
  final Function(DateTime selectedDate)? popupSelectedDateBuilder;

  /// Custom builder for the button to switch to the date view.
  final Function(
    Function() selectDateView,
    DateTime selectedDate,
    bool isSelected,
  )?
  dateViewButtonBuilder;

  /// Custom builder for the button to switch to the month view.
  final Function(
    Function() selectMonthView,
    DateTime selectedDate,
    bool isSelected,
  )?
  monthViewButtonBuilder;

  /// Custom builder for the button to switch to the year view.
  final Function(
    Function() selectYearView,
    DateTime selectedDate,
    bool isSelected,
  )?
  yearViewButtonBuilder;

  /// Custom builder for the weekday cells.
  final Function(String day, bool isToday)? weekdayCellBuilder;

  /// Custom builder for the date cells.
  final Function(
    Function() selectdate,
    bool isSelected,
    bool isInTheCurrentMonth,
    bool isAvailable,
    int day,
  )?
  dateCellBuilder;

  /// Custom builder for the month cells.
  final Function(
    Function() selectMonth,
    String month,
    bool isSelected,
    bool isAvailable,
  )?
  monthCellBuilder;

  /// Custom builder for the year cells.
  final Function(
    Function() selectYear,
    int year,
    bool isSelected,
    bool isAvailable,
  )?
  yearCellBuilder;

  /// Callback triggered when the view state changes.
  final Function(ViewState viewState)? onViewStateChanged;

  /// Callback triggered when the selected date changes.
  final Function(DateTime date) onSelectedDateChanged;

  @override
  State<CreateDatePicker> createState() => _CreateDatePickerState();
}

class _CreateDatePickerState extends State<CreateDatePicker> {
  late ViewState _viewState = widget.initialViewState;

  late DateTime _selectedDate = widget.initialDate ?? DateTime.now();

  final int _yearGridCount = 25;

  late List<int> _years = _generateYearList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: widget.width, child: _body());
  }

  Widget _body() {
    if (widget.builder != null) {
      return widget.builder!(
        _selectedDate,
        _viewState,
        _buildLeftArrow(),
        _buildRightArrow(),
        _buildPopupSelectedDate(),
        _buildDateViewButton(),
        _buildMonthViewButton(),
        _buildYearViewButton(),
        _buildWeekday(),
        _buildDateMonthYear(_viewState),
        _buildDateMonthYear(ViewState.date),
        _buildDateMonthYear(ViewState.month),
        _buildDateMonthYear(ViewState.year),
      );
    }

    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.white,
      elevation: widget.elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildWeekday(),
            SizedBox(height: 10),
            _buildDateMonthYear(_viewState),
          ],
        ),
      ),
    );
  }

  void _swipeLeft() {
    if (_viewState == ViewState.date) {
      final previousMonth = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        0,
      );
      final newDate = DateTime(
        previousMonth.year,
        previousMonth.month,
        _selectedDate.day > previousMonth.day
            ? previousMonth.day
            : _selectedDate.day,
      );
      if (widget.minDateTime == null ||
          !newDate.isBefore(widget.minDateTime!)) {
        _selectedDate = newDate;
      } else {
        _selectedDate = widget.minDateTime!;
      }
    } else if (_viewState == ViewState.month) {
      final newDate = DateTime(
        _selectedDate.year - 1,
        _selectedDate.month,
        _selectedDate.day,
      );
      if (widget.minDateTime == null ||
          !newDate.isBefore(widget.minDateTime!)) {
        _selectedDate = newDate;
      } else {
        _selectedDate = DateTime(
          widget.minDateTime!.year,
          widget.minDateTime!.month,
          _selectedDate.day > widget.minDateTime!.day
              ? widget.minDateTime!.day
              : _selectedDate.day,
        );
      }
    } else if (_viewState == ViewState.year) {
      final newYears = List.generate(
        _yearGridCount,
        (index) => (_years.first - _yearGridCount + 1) + index,
      );
      if (widget.minDateTime == null ||
          newYears.last >= widget.minDateTime!.year) {
        _years = newYears;
      }
    }
    setState(() {});
  }

  void _swipeRight() {
    if (_viewState == ViewState.date) {
      final nextMonth = DateTime(
        _selectedDate.year,
        _selectedDate.month + 2,
        0,
      );
      final newDate = DateTime(
        nextMonth.year,
        nextMonth.month,
        _selectedDate.day > nextMonth.day ? nextMonth.day : _selectedDate.day,
      );
      if (widget.maxDateTime == null || !newDate.isAfter(widget.maxDateTime!)) {
        _selectedDate = newDate;
      } else {
        _selectedDate = widget.maxDateTime!;
      }
    } else if (_viewState == ViewState.month) {
      final newDate = DateTime(
        _selectedDate.year + 1,
        _selectedDate.month,
        _selectedDate.day,
      );
      if (widget.maxDateTime == null || !newDate.isAfter(widget.maxDateTime!)) {
        _selectedDate = newDate;
      } else {
        _selectedDate = DateTime(
          widget.maxDateTime!.year,
          widget.maxDateTime!.month,
          _selectedDate.day > widget.maxDateTime!.day
              ? widget.maxDateTime!.day
              : _selectedDate.day,
        );
      }
    } else if (_viewState == ViewState.year) {
      final newYears = List.generate(
        _yearGridCount,
        (index) => _years.last + index,
      );
      if (widget.maxDateTime == null ||
          newYears.first <= widget.maxDateTime!.year) {
        _years = newYears;
      }
    }
    setState(() {});
  }

  void _changeView(ViewState newValue) {
    setState(() {
      _viewState = newValue;
      if (newValue == ViewState.year) {
        _years = _generateYearList();
      }
    });
    widget.onViewStateChanged?.call(newValue);
  }

  void _selectDate(int day) {
    final newDate = DateTime(_selectedDate.year, _selectedDate.month, day);
    if (_dateIsAvailable(newDate)) {
      _selectedDate = newDate;
      widget.onSelectedDateChanged(newDate);
      setState(() {});
    }
  }

  void _selectMonth(int index) {
    final selectedMonth = DateTime(_selectedDate.year, index + 2, 0);
    final newDate = DateTime(
      _selectedDate.year,
      index + 1,
      _selectedDate.day > selectedMonth.day
          ? selectedMonth.day
          : _selectedDate.day,
    );

    // Adjust the day to the nearest valid date if restricted or exceeds maxDateTime
    final adjustedDate = _adjustToValidDate(newDate);

    // Ensure the adjusted date does not exceed maxDateTime or is below minDateTime
    final finalDate =
        (widget.maxDateTime != null &&
                adjustedDate.isAfter(widget.maxDateTime!))
            ? widget.maxDateTime!
            : (widget.minDateTime != null &&
                adjustedDate.isBefore(widget.minDateTime!))
            ? widget.minDateTime!
            : adjustedDate;

    if (_monthIsAvailable(finalDate)) {
      _selectedDate = finalDate;
      widget.onSelectedDateChanged(finalDate);
      setState(() {});
    }
  }

  void _selectYear(int year) {
    final selectedYear = DateTime(year, _selectedDate.month + 1, 0);
    final newDate = DateTime(
      year,
      _selectedDate.month,
      _selectedDate.day > selectedYear.day
          ? selectedYear.day
          : _selectedDate.day,
    );

    // Adjust the day to the nearest valid date if restricted or exceeds maxDateTime
    final adjustedDate = _adjustToValidDate(newDate);

    // Ensure the adjusted date does not exceed maxDateTime or is below minDateTime
    final finalDate =
        (widget.maxDateTime != null &&
                adjustedDate.isAfter(widget.maxDateTime!))
            ? widget.maxDateTime!
            : (widget.minDateTime != null &&
                adjustedDate.isBefore(widget.minDateTime!))
            ? widget.minDateTime!
            : adjustedDate;

    if (_yearIsAvailable(finalDate)) {
      _selectedDate = finalDate;
      widget.onSelectedDateChanged(finalDate);
      setState(() {});
    }
  }

  DateTime _adjustToValidDate(DateTime date) {
    // Adjust the date to the nearest valid date if restricted
    if (widget.restrictedDates.any(
      (restrictedDate) =>
          restrictedDate.year == date.year &&
          restrictedDate.month == date.month &&
          restrictedDate.day == date.day,
    )) {
      return DateTime(
        date.year,
        date.month,
        1,
      ); // Default to the 1st of the month
    }
    return date;
  }

  bool _dateIsAvailable(DateTime date) {
    if (widget.minDateTime != null && date.isBefore(widget.minDateTime!)) {
      return false;
    }
    if (widget.maxDateTime != null && date.isAfter(widget.maxDateTime!)) {
      return false;
    }
    if (widget.restrictedDates.any((restrictedDate) {
      return date.year == restrictedDate.year &&
          date.month == restrictedDate.month &&
          date.day == restrictedDate.day;
    })) {
      return false;
    }
    return true;
  }

  bool _monthIsAvailable(DateTime date) {
    if (widget.minDateTime != null &&
        date.isBefore(
          DateTime(widget.minDateTime!.year, widget.minDateTime!.month, 1),
        )) {
      return false;
    }
    if (widget.maxDateTime != null &&
        date.isAfter(
          DateTime(widget.maxDateTime!.year, widget.maxDateTime!.month + 1, 0),
        )) {
      return false;
    }

    return true;
  }

  bool _yearIsAvailable(DateTime date) {
    if (widget.minDateTime != null && date.year < widget.minDateTime!.year) {
      return false;
    }
    if (widget.maxDateTime != null && date.year > widget.maxDateTime!.year) {
      return false;
    }

    return true;
  }

  List<int> _generateYearList() {
    return List.generate(_yearGridCount, (index) => _selectedDate.year + index);
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${widget.monthLabels[date.month - 1]} ${date.year}';
  }

  bool _isSelectedDate(DateTime date) {
    return date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;
  }

  Widget _buildLeftArrow() {
    if (widget.leftArrowBuilder != null) {
      return widget.leftArrowBuilder!(_swipeLeft);
    }
    return GestureDetector(
      onTap: _swipeLeft,
      child: const Icon(Icons.arrow_left),
    );
  }

  Widget _buildRightArrow() {
    if (widget.rightArrowBuilder != null) {
      return widget.rightArrowBuilder!(_swipeRight);
    }
    return GestureDetector(
      onTap: _swipeRight,
      child: const Icon(Icons.arrow_right),
    );
  }

  Widget _buildPopupSelectedDate() {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton<ViewState>(
        onSelected: _changeView,
        tooltip: 'Change View',
        color: Colors.white,
        position: widget.popupMenuPosition,
        offset: widget.popupMenuOffset ?? Offset(1, 0),
        itemBuilder: (context) {
          return ViewState.values.map((state) {
            return PopupMenuItem<ViewState>(
              value: state,
              child: Text(
                state == ViewState.date
                    ? 'Date'
                    : state == ViewState.month
                    ? 'Month'
                    : 'Year',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          }).toList();
        },
        child:
            widget.popupSelectedDateBuilder != null
                ? widget.popupSelectedDateBuilder!(_selectedDate)
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatDate(_selectedDate),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildDateViewButton() {
    final isSelected = _viewState == ViewState.date;
    if (widget.dateViewButtonBuilder != null) {
      return widget.dateViewButtonBuilder!(
        () => _changeView(ViewState.date),
        _selectedDate,
        isSelected,
      );
    }
    return GestureDetector(
      onTap: () => _changeView(ViewState.date),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildMonthViewButton() {
    final isSelected = _viewState == ViewState.month;
    if (widget.monthViewButtonBuilder != null) {
      return widget.monthViewButtonBuilder!(
        () => _changeView(ViewState.month),
        _selectedDate,
        isSelected,
      );
    }

    return GestureDetector(
      onTap: () => _changeView(ViewState.month),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Month',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildYearViewButton() {
    final isSelected = _viewState == ViewState.year;
    if (widget.yearViewButtonBuilder != null) {
      return widget.yearViewButtonBuilder!(
        () => _changeView(ViewState.year),
        _selectedDate,
        _viewState == ViewState.year,
      );
    }

    return GestureDetector(
      onTap: () => _changeView(ViewState.year),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Year',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Default header builder
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeftArrow(),
          _buildPopupSelectedDate(),
          _buildRightArrow(),
        ],
      ),
    );
  }

  Widget _buildWeekday() {
    if (_viewState != ViewState.date && widget.weekdayCellBuilder == null) {
      return SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.weekLabels.length, (index) {
            final today = DateTime.now();
            final isToday = today.weekday % 7 == index;
            final day = widget.weekLabels[index];

            if (widget.weekdayCellBuilder != null) {
              return SizedBox(
                width: constraints.maxWidth / 7,
                child: widget.weekdayCellBuilder!(day, isToday),
              );
            }

            return Container(
              width: constraints.maxWidth / 7,
              decoration:
                  isToday
                      ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      )
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
          }),
        );
      },
    );
  }

  Widget _buildDateMonthYear(ViewState view) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount:
          view == ViewState.date
              ? 7
              : view == ViewState.month
              ? 4
              : 5,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children:
          view == ViewState.date
              ? _buildDateGrid()
              : view == ViewState.month
              ? _buildMonthGrid()
              : _buildYearGrid(),
    );
  }

  Widget _buildDateCell(
    int day, {
    bool isSelected = false,
    bool isInTheCurrentMonth = true,
    bool isAvailable = true,
  }) {
    if (widget.dateCellBuilder != null) {
      return widget.dateCellBuilder!(
        () => isInTheCurrentMonth ? _selectDate(day) : null,
        isSelected,
        isInTheCurrentMonth,
        isAvailable,
        day,
      );
    }

    return GestureDetector(
      onTap: isInTheCurrentMonth ? () => _selectDate(day) : null,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
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
    );
  }

  List<Widget> _buildDateGrid() {
    final firstDayOfMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month + 1,
      0,
    );
    final daysInMonth = lastDayOfMonth.day;

    final startWeekday = firstDayOfMonth.weekday % 7;
    final previousMonthLastDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      0,
    );
    final previousMonthDays = List.generate(
      startWeekday == 0 ? 6 : startWeekday - 1,
      (index) =>
          previousMonthLastDay.day -
          (startWeekday == 0 ? 6 : startWeekday - 1) +
          index +
          1,
    );

    final List<Widget> dateWidgets =
        previousMonthDays.map((day) {
          final date = DateTime(
            _selectedDate.year,
            _selectedDate.month - 1,
            day,
          );
          return _buildDateCell(
            day,
            isInTheCurrentMonth: false,
            isAvailable: _dateIsAvailable(date),
          );
        }).toList();

    dateWidgets.addAll(
      List.generate(daysInMonth, (index) {
        final date = firstDayOfMonth.add(Duration(days: index));
        return _buildDateCell(
          date.day,
          isSelected: _isSelectedDate(date),
          isAvailable: _dateIsAvailable(date),
        );
      }),
    );

    final endWeekday = lastDayOfMonth.weekday % 7;
    final nextMonthDays = List.generate(
      endWeekday == 0 ? 0 : 7 - endWeekday,
      (index) => index + 1,
    );

    dateWidgets.addAll(
      nextMonthDays.map((day) {
        final date = DateTime(_selectedDate.year, _selectedDate.month + 1, day);
        return _buildDateCell(
          day,
          isInTheCurrentMonth: false,
          isAvailable: _dateIsAvailable(date),
        );
      }).toList(),
    );

    return dateWidgets;
  }

  Widget _buildMonthCell(int monthIndex, bool isSelected) {
    final month = widget.monthLabels[monthIndex];
    final isAvailable = _monthIsAvailable(
      DateTime(_selectedDate.year, monthIndex + 1, 1),
    );

    if (widget.monthCellBuilder != null) {
      return widget.monthCellBuilder!(
        () => _selectMonth(monthIndex),
        month,
        isSelected,
        isAvailable,
      );
    }

    return GestureDetector(
      onTap: () => _selectMonth(monthIndex),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
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
    );
  }

  List<Widget> _buildMonthGrid() {
    return List.generate(12, (index) {
      final isSelected = _selectedDate.month == index + 1;
      return _buildMonthCell(index, isSelected);
    });
  }

  Widget _buildYearCell(int year, bool isSelected) {
    final isAvailable = _yearIsAvailable(DateTime(year));

    if (widget.yearCellBuilder != null) {
      return widget.yearCellBuilder!(
        () => _selectYear(year),
        year,
        isSelected,
        isAvailable,
      );
    }

    return GestureDetector(
      onTap: () => _selectYear(year),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
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
    );
  }

  List<Widget> _buildYearGrid() {
    return _years.map((year) {
      final isSelected = _selectedDate.year == year;
      return _buildYearCell(year, isSelected);
    }).toList();
  }
}
