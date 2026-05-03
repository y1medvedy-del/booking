import 'package:flutter/material.dart';
import 'package:booking/features/home/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _emptyStateImagePath =
      'docs/imgs/Empty State Illustrations_Light Mode_No Location Found.png';

  int _selectedIndex = 0;
  bool _isMapMode = false;
  int? _selectedMapStayIndex;
  _StaySearchCriteria _searchCriteria = _StaySearchCriteria.initial();
  _StayFilterCriteria _filterCriteria = _StayFilterCriteria.initial();

  static const _stays = <_StayCardData>[
    _StayCardData(
      title: 'Уютная студия в центре Москвы',
      city: 'Москва',
      type: 'Квартира',
      dates: '14-19 ноября',
      nights: '5 ночей',
      totalPrice: '15 170 ₽',
      nightPrice: '3 034 ₽ / ночь',
      rating: '4.5',
      reviews: '13',
      imagePath: 'docs/imgs/onbord1.png',
      isFavorite: false,
      activePhotoIndex: 0,
      coordinates: LatLng(55.7566, 37.6128),
    ),
    _StayCardData(
      title: 'Квартира в старом городе',
      city: 'Москва',
      type: 'Квартира',
      dates: '14-19 ноября',
      nights: '5 ночей',
      totalPrice: '18 900 ₽',
      nightPrice: '3 780 ₽ / ночь',
      rating: '4.7',
      reviews: '29',
      imagePath: 'docs/imgs/onbord2.png',
      isFavorite: true,
      activePhotoIndex: 1,
      coordinates: LatLng(55.7582, 37.6194),
    ),
    _StayCardData(
      title: 'Апартаменты рядом с парком',
      city: 'Санкт-Петербург',
      type: 'Апартаменты',
      dates: '21-26 ноября',
      nights: '5 ночей',
      totalPrice: '22 500 ₽',
      nightPrice: '4 500 ₽ / ночь',
      rating: '4.9',
      reviews: '41',
      imagePath: 'docs/imgs/onbord3.png',
      isFavorite: false,
      activePhotoIndex: 2,
      coordinates: LatLng(55.7532, 37.6222),
    ),
    _StayCardData(
      title: 'Частный дом в 10 км от Москвы',
      city: 'Москва',
      type: 'Дом',
      dates: '14-19 ноября',
      nights: '5 ночей',
      totalPrice: '16 470 ₽',
      nightPrice: '3 294 ₽ / ночь',
      rating: '4.5',
      reviews: '13',
      imagePath: 'docs/imgs/onbord1.png',
      isFavorite: false,
      activePhotoIndex: 1,
      coordinates: LatLng(55.7516, 37.6152),
    ),
  ];

  Future<void> _openSearchSheet() async {
    final result = await showModalBottomSheet<_StaySearchCriteria>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _StaySearchBottomSheet(initialCriteria: _searchCriteria),
    );

    if (result == null) {
      return;
    }

    setState(() {
      _searchCriteria = result;
    });
  }

  Future<void> _openFilterSheet() async {
    final result = await showModalBottomSheet<_StayFilterCriteria>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _StayFilterBottomSheet(initialCriteria: _filterCriteria),
    );

    if (result == null) {
      return;
    }

    setState(() {
      _filterCriteria = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 44, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFFF88A2A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _openSearchSheet,
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFF6ED),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0xCCF88A2A),
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search_rounded,
                                  size: 16,
                                  color: Color(0xFF525252),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _searchCriteria.searchLabel,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFF525252),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _HeaderCircleButton(
                        icon: Icons.tune_rounded,
                        onTap: _openFilterSheet,
                        badgeCount: _filterCriteria.activeFilterCount,
                      ),
                      const SizedBox(width: 8),
                      _HeaderCircleButton(
                        icon: Icons.map_outlined,
                        isSelected: _isMapMode,
                        onTap: () {
                          setState(() {
                            _isMapMode = !_isMapMode;
                            _selectedMapStayIndex = _isMapMode ? 3 : null;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_searchCriteria.chipLabels.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _searchCriteria.chipLabels.map((label) {
                          return _SearchCriteriaChip(label: label);
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: _isMapMode
                ? _StayMapView(
                    stays: _stays,
                    emptyStateImagePath: _emptyStateImagePath,
                    selectedIndex: _selectedMapStayIndex,
                    onPinTap: (index) {
                      setState(() {
                        _selectedMapStayIndex = index;
                      });
                    },
                    onCloseCard: () {
                      setState(() {
                        _selectedMapStayIndex = null;
                      });
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: _stays.isEmpty
                        ? const _StayListEmptyState(
                            imagePath: _emptyStateImagePath,
                          )
                        : ListView.separated(
                            // Physics не задаем вручную: Flutter сам выбирает стандартное
                            // поведение скролла для текущей платформы.
                            padding: const EdgeInsets.only(bottom: 24),
                            itemCount: _stays.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 24),
                            itemBuilder: (context, index) {
                              return _StayCard(data: _stays[index]);
                            },
                          ),
                  ),
          ),
          AppBottomNavBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({
    required this.icon,
    required this.onTap,
    this.badgeCount = 0,
    this.isSelected = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final int badgeCount;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFF1A1B1C)
                    : const Color(0xFFFFF6ED),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xCCF88A2A)),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? Colors.white : const Color(0xFF7A4310),
              ),
            ),
            if (badgeCount > 0)
              Positioned(
                top: -8,
                right: -4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 28),
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE94259),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    badgeCount > 9 ? '9+' : '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SearchCriteriaChip extends StatelessWidget {
  const _SearchCriteriaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
      ),
    );
  }
}

class _StaySearchCriteria {
  const _StaySearchCriteria({
    required this.city,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.pets,
  });

  factory _StaySearchCriteria.initial() {
    return _StaySearchCriteria(
      city: '',
      checkInDate: null,
      checkOutDate: null,
      adults: 0,
      children: 0,
      pets: 0,
    );
  }

  final String city;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int adults;
  final int children;
  final int pets;

  String get searchLabel {
    if (city.trim().isEmpty) {
      return 'Хочу снять жилье в…';
    }

    return city.trim();
  }

  List<String> get chipLabels {
    final labels = <String>[];
    final trimmedCity = city.trim();

    if (trimmedCity.isNotEmpty) {
      labels.add(trimmedCity);
    }

    if (checkInDate != null && checkOutDate != null) {
      labels.add(
        '${_formatShortDate(checkInDate!)}-${_formatShortDate(checkOutDate!)}',
      );
    }

    if (adults > 0) {
      labels.add(_pluralizeAdults(adults));
    }

    if (children > 0) {
      labels.add(_pluralizeChildren(children));
    }

    return labels;
  }

  _StaySearchCriteria copyWith({
    String? city,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? adults,
    int? children,
    int? pets,
  }) {
    return _StaySearchCriteria(
      city: city ?? this.city,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      pets: pets ?? this.pets,
    );
  }
}

class _StayFilterCriteria {
  const _StayFilterCriteria({
    required this.housingTypes,
    required this.priceRange,
    required this.amenities,
    required this.features,
  });

  static const RangeValues defaultPriceRange = RangeValues(2500, 7000);

  factory _StayFilterCriteria.initial() {
    return const _StayFilterCriteria(
      housingTypes: <String>{},
      priceRange: defaultPriceRange,
      amenities: <String>{},
      features: <String>{},
    );
  }

  final Set<String> housingTypes;
  final RangeValues priceRange;
  final Set<String> amenities;
  final Set<String> features;

  int get activeFilterCount {
    var count = housingTypes.length + amenities.length + features.length;

    if (priceRange.start != defaultPriceRange.start ||
        priceRange.end != defaultPriceRange.end) {
      count += 1;
    }

    return count;
  }

  bool get hasActiveFilters {
    return activeFilterCount > 0;
  }

  bool hasSameValues(_StayFilterCriteria other) {
    return _hasSameSetValues(housingTypes, other.housingTypes) &&
        _hasSameSetValues(amenities, other.amenities) &&
        _hasSameSetValues(features, other.features) &&
        priceRange.start == other.priceRange.start &&
        priceRange.end == other.priceRange.end;
  }
}

class _StaySearchBottomSheet extends StatefulWidget {
  const _StaySearchBottomSheet({required this.initialCriteria});

  final _StaySearchCriteria initialCriteria;

  @override
  State<_StaySearchBottomSheet> createState() => _StaySearchBottomSheetState();
}

class _StaySearchBottomSheetState extends State<_StaySearchBottomSheet> {
  final TextEditingController _cityController = TextEditingController();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _adults = 0;
  int _children = 0;
  int _pets = 0;

  @override
  void initState() {
    super.initState();
    final criteria = widget.initialCriteria;
    _cityController.text = criteria.city;
    _checkInDate = criteria.checkInDate;
    _checkOutDate = criteria.checkOutDate;
    _adults = criteria.adults;
    _children = criteria.children;
    _pets = criteria.pets;
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _incrementAdults() => setState(() => _adults += 1);
  void _incrementChildren() => setState(() => _children += 1);
  void _incrementPets() => setState(() => _pets += 1);

  void _decrementAdults() {
    if (_adults == 0) {
      return;
    }

    setState(() => _adults -= 1);
  }

  void _decrementChildren() {
    if (_children == 0) {
      return;
    }

    setState(() => _children -= 1);
  }

  void _decrementPets() {
    if (_pets == 0) {
      return;
    }

    setState(() => _pets -= 1);
  }

  Future<void> _selectCheckInDate() async {
    final selectedDate = await _showSearchDatePicker(
      _checkInDate ?? DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _checkInDate = selectedDate;

      if (_checkOutDate != null && !_checkOutDate!.isAfter(_checkInDate!)) {
        _checkOutDate = _checkInDate!.add(const Duration(days: 1));
      }
    });
  }

  Future<void> _selectCheckOutDate() async {
    final selectedDate = await _showSearchDatePicker(
      _checkOutDate ??
          _checkInDate?.add(const Duration(days: 1)) ??
          DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      if (_checkInDate == null) {
        _checkOutDate = selectedDate;
        return;
      }

      _checkOutDate = selectedDate.isAfter(_checkInDate!)
          ? selectedDate
          : _checkInDate!.add(const Duration(days: 1));
    });
  }

  Future<DateTime?> _showSearchDatePicker(DateTime initialDate) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2027),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFFF88A2A),
              secondary: const Color(0xFFF88A2A),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  void _saveCriteria() {
    Navigator.of(context).pop(
      _StaySearchCriteria(
        city: _cityController.text.trim(),
        checkInDate: _checkInDate,
        checkOutDate: _checkOutDate,
        adults: _adults,
        children: _children,
        pets: _pets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final hasGuests = _adults + _children > 0;
    final canSearch =
        _cityController.text.trim().isNotEmpty &&
        _checkInDate != null &&
        _checkOutDate != null &&
        hasGuests;
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.72;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SizedBox(
        height: sheetHeight,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Column(
                children: [
                  Container(
                    width: 43,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E5EA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 47),
                          const Text(
                            'Снять жилье',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1A1B1C),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 54),
                          _SheetFieldLabel(
                            label: 'Город',
                            child: _CitySearchField(
                              controller: _cityController,
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                child: _SheetFieldLabel(
                                  label: 'Дата заезда',
                                  child: _SheetValueButton(
                                    label: _formatSearchDate(
                                      _checkInDate,
                                      fallback: '14.11.2024',
                                    ),
                                    isFilled: _checkInDate != null,
                                    icon: Icons.calendar_month_outlined,
                                    onTap: _selectCheckInDate,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _SheetFieldLabel(
                                  label: 'Дата выезда',
                                  child: _SheetValueButton(
                                    label: _formatSearchDate(
                                      _checkOutDate,
                                      fallback: '15.11.2024',
                                    ),
                                    isFilled: _checkOutDate != null,
                                    icon: Icons.calendar_month_outlined,
                                    onTap: _selectCheckOutDate,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          _GuestCounterRow(
                            title: 'Количество взрослых',
                            subtitle: '12 лет и старше',
                            value: _adults,
                            onMinus: _decrementAdults,
                            onPlus: _incrementAdults,
                          ),
                          const SizedBox(height: 24),
                          _GuestCounterRow(
                            title: 'Количество детей',
                            subtitle: '0-11 лет',
                            value: _children,
                            onMinus: _decrementChildren,
                            onPlus: _incrementChildren,
                          ),
                          const SizedBox(height: 24),
                          _GuestCounterRow(
                            title: 'Количество животных',
                            value: _pets,
                            onMinus: _decrementPets,
                            onPlus: _incrementPets,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFF88A2A),
                            side: const BorderSide(color: Color(0xFFF88A2A)),
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          child: const Text('Вернуться'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: canSearch ? _saveCriteria : null,
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFF88A2A),
                            disabledBackgroundColor: const Color(0x66F88A2A),
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          child: const Text('Найти'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetFieldLabel extends StatelessWidget {
  const _SheetFieldLabel({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1A1B1C),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

String _formatSearchDate(DateTime? date, {required String fallback}) {
  if (date == null) {
    return fallback;
  }

  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');

  return '$day.$month.${date.year}';
}

String _formatShortDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = _monthNames[date.month - 1];

  return '$day $month';
}

String _pluralizeAdults(int count) {
  final mod10 = count % 10;
  final mod100 = count % 100;

  if (mod10 == 1 && mod100 != 11) {
    return '$count взрослый';
  }

  return '$count взрослых';
}

String _pluralizeChildren(int count) {
  final mod10 = count % 10;
  final mod100 = count % 100;

  if (mod10 == 1 && mod100 != 11) {
    return '$count ребенок';
  }

  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return '$count ребенка';
  }

  return '$count детей';
}

bool _hasSameSetValues(Set<String> first, Set<String> second) {
  if (first.length != second.length) {
    return false;
  }

  return first.containsAll(second);
}

const _monthNames = <String>[
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

class _CitySearchField extends StatelessWidget {
  const _CitySearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          color: Color(0xFF1A1B1C),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.45,
        ),
        decoration: InputDecoration(
          hintText: 'Укажите город',
          hintStyle: const TextStyle(
            color: Color(0xFF89919D),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF1A1B1C),
            size: 24,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Color(0xFFF88A2A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Color(0xFFF88A2A)),
          ),
        ),
      ),
    );
  }
}

class _SheetValueButton extends StatelessWidget {
  const _SheetValueButton({
    required this.label,
    required this.isFilled,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final bool isFilled;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFF88A2A)),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isFilled
                      ? const Color(0xFF1A1B1C)
                      : const Color(0xFF89919D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                ),
              ),
            ),
            Icon(icon, color: const Color(0xFF89919D), size: 20),
          ],
        ),
      ),
    );
  }
}

class _GuestCounterRow extends StatelessWidget {
  const _GuestCounterRow({
    required this.title,
    required this.value,
    required this.onMinus,
    required this.onPlus,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    final canMinus = value > 0;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A1B1C),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(
                    color: Color(0xFF89919D),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 98,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CounterButton(
                icon: Icons.remove_rounded,
                isEnabled: canMinus,
                onTap: onMinus,
              ),
              Text(
                '$value',
                style: const TextStyle(
                  color: Color(0xFF1A1B1C),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                ),
              ),
              _CounterButton(
                icon: Icons.add_rounded,
                isEnabled: true,
                onTap: onPlus,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.icon,
    required this.isEnabled,
    required this.onTap,
  });

  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isEnabled ? const Color(0xFFF88A2A) : const Color(0xFFBBC1C9);

    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 34,
        height: 34,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Icon(icon, color: color, size: 16),
      ),
    );
  }
}

class _StayFilterBottomSheet extends StatefulWidget {
  const _StayFilterBottomSheet({required this.initialCriteria});

  final _StayFilterCriteria initialCriteria;

  @override
  State<_StayFilterBottomSheet> createState() => _StayFilterBottomSheetState();
}

class _StayFilterBottomSheetState extends State<_StayFilterBottomSheet> {
  static const _housingTypes = <String>['Квартира', 'Дом', 'Комната', 'Отель'];

  static const _amenities = <_FilterChipData>[
    _FilterChipData(label: 'Wifi', icon: Icons.wifi_rounded),
    _FilterChipData(label: 'Телевизор', icon: Icons.tv_outlined),
    _FilterChipData(label: 'Кондиционер', icon: Icons.ac_unit_rounded),
    _FilterChipData(label: 'Обогреватель', icon: Icons.device_thermostat),
    _FilterChipData(label: 'Фен', icon: Icons.air_rounded),
    _FilterChipData(label: 'Утюг', icon: Icons.checkroom_outlined),
    _FilterChipData(label: 'Кухня', icon: Icons.kitchen_outlined),
    _FilterChipData(
      label: 'Стиральная машина',
      icon: Icons.local_laundry_service_outlined,
    ),
    _FilterChipData(label: 'Посуда', icon: Icons.local_dining_outlined),
  ];

  static const _features = <_FilterChipData>[
    _FilterChipData(label: 'Завтраки', icon: Icons.free_breakfast_outlined),
    _FilterChipData(label: 'Бассейн', icon: Icons.pool_rounded),
    _FilterChipData(label: 'Камин', icon: Icons.fireplace_outlined),
    _FilterChipData(label: 'Разрешено курение', icon: Icons.smoking_rooms),
    _FilterChipData(label: 'Спортзал', icon: Icons.fitness_center_rounded),
    _FilterChipData(
      label: 'Самостоятельное заселение',
      icon: Icons.vpn_key_outlined,
    ),
    _FilterChipData(label: 'Сауна', icon: Icons.hot_tub_outlined),
    _FilterChipData(label: 'Парковка', icon: Icons.local_parking_outlined),
  ];

  Set<String> _housingTypesSelected = <String>{};
  RangeValues _priceRange = _StayFilterCriteria.defaultPriceRange;
  Set<String> _amenitiesSelected = <String>{};
  Set<String> _featuresSelected = <String>{};
  _StayFilterCriteria _initialCriteria = _StayFilterCriteria.initial();
  bool _wasResetPressed = false;

  @override
  void initState() {
    super.initState();
    final criteria = widget.initialCriteria;
    _initialCriteria = criteria;
    _housingTypesSelected = Set<String>.from(criteria.housingTypes);
    _priceRange = criteria.priceRange;
    _amenitiesSelected = Set<String>.from(criteria.amenities);
    _featuresSelected = Set<String>.from(criteria.features);
  }

  bool get _canApply {
    // После ручного сброса разрешаем нажать "Применить",
    // чтобы пустые фильтры точно вернулись на главный экран.
    return _wasResetPressed ||
        !_currentCriteria.hasSameValues(_initialCriteria);
  }

  _StayFilterCriteria get _currentCriteria {
    return _StayFilterCriteria(
      housingTypes: _housingTypesSelected,
      priceRange: _priceRange,
      amenities: _amenitiesSelected,
      features: _featuresSelected,
    );
  }

  void _toggleValue(Set<String> values, String value) {
    setState(() {
      if (values.contains(value)) {
        values.remove(value);
      } else {
        values.add(value);
      }
    });
  }

  void _resetFilters() {
    setState(() {
      _housingTypesSelected = <String>{};
      _priceRange = _StayFilterCriteria.defaultPriceRange;
      _amenitiesSelected = <String>{};
      _featuresSelected = <String>{};
      _wasResetPressed = true;
    });
  }

  void _applyFilters() {
    Navigator.of(context).pop(_currentCriteria);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.96;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SizedBox(
        height: sheetHeight,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: Column(
                children: [
                  Container(
                    width: 43,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E5EA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 32, bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Фильтры',
                              style: TextStyle(
                                color: Color(0xFF1A1B1C),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          _FilterSection(
                            title: 'Вид жилья',
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _housingTypes.map((type) {
                                return _FilterPill(
                                  label: type,
                                  isSelected: _housingTypesSelected.contains(
                                    type,
                                  ),
                                  onTap: () =>
                                      _toggleValue(_housingTypesSelected, type),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _FilterSection(
                            title: 'Диапазон цен',
                            child: _PriceRangeFilter(
                              values: _priceRange,
                              onChanged: (values) {
                                setState(() {
                                  _priceRange = values;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                          _FilterSection(
                            title: 'Удобства',
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _amenities.map((item) {
                                return _FilterPill(
                                  label: item.label,
                                  icon: item.icon,
                                  isSelected: _amenitiesSelected.contains(
                                    item.label,
                                  ),
                                  onTap: () => _toggleValue(
                                    _amenitiesSelected,
                                    item.label,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _FilterSection(
                            title: 'Дополнительные характеристики',
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _features.map((item) {
                                return _FilterPill(
                                  label: item.label,
                                  icon: item.icon,
                                  isSelected: _featuresSelected.contains(
                                    item.label,
                                  ),
                                  onTap: () => _toggleValue(
                                    _featuresSelected,
                                    item.label,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextButton(
                            onPressed: _resetFilters,
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFF88A2A),
                              padding: EdgeInsets.zero,
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                height: 1.4,
                              ),
                            ),
                            child: const Text('Сбросить фильтры'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFF88A2A),
                            side: const BorderSide(color: Color(0xFFF88A2A)),
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          child: const Text('Вернуться'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _canApply ? _applyFilters : null,
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFF88A2A),
                            disabledBackgroundColor: const Color(0x66F88A2A),
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                          child: const Text('Применить'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1A1B1C),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isSelected ? Colors.white : const Color(0xFFF88A2A);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFF88A2A) : Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFF88A2A)),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: foregroundColor, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: foregroundColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRangeFilter extends StatelessWidget {
  const _PriceRangeFilter({required this.values, required this.onChanged});

  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 66),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PriceLabel(value: values.start),
              _PriceLabel(value: values.end),
            ],
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFFF88A2A),
            inactiveTrackColor: const Color(0xFFE2E5EA),
            thumbColor: const Color(0xFFF88A2A),
            overlayColor: const Color(0x1FF88A2A),
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 13,
              elevation: 2,
            ),
            rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
            trackHeight: 3,
          ),
          child: RangeSlider(
            values: values,
            min: 1000,
            max: 9000,
            divisions: 80,
            onChanged: onChanged,
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'от 1 000 ₽',
              style: TextStyle(
                color: Color(0xFF89919D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
            Text(
              'до 9 000₽',
              style: TextStyle(
                color: Color(0xFF89919D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceLabel extends StatelessWidget {
  const _PriceLabel({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value.round()} ₽',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _FilterChipData {
  const _FilterChipData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class _StayMapView extends StatelessWidget {
  const _StayMapView({
    required this.stays,
    required this.emptyStateImagePath,
    required this.selectedIndex,
    required this.onPinTap,
    required this.onCloseCard,
  });

  final List<_StayCardData> stays;
  final String emptyStateImagePath;
  final int? selectedIndex;
  final ValueChanged<int> onPinTap;
  final VoidCallback onCloseCard;

  @override
  Widget build(BuildContext context) {
    final selectedStay =
        selectedIndex == null ||
            selectedIndex! < 0 ||
            selectedIndex! >= stays.length
        ? null
        : stays[selectedIndex!];

    return Stack(
      children: [
        Positioned.fill(
          child: _GeoapifyStayMap(
            stays: stays,
            selectedIndex: selectedIndex,
            onPinTap: onPinTap,
          ),
        ),
        if (stays.isEmpty)
          Positioned(
            left: 24,
            right: 24,
            bottom: 72,
            child: _StayMapEmptyState(imagePath: emptyStateImagePath),
          ),
        if (selectedStay != null)
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: _MapStayCard(data: selectedStay, onClose: onCloseCard),
          ),
      ],
    );
  }
}

class _StayListEmptyState extends StatelessWidget {
  const _StayListEmptyState({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 64),
        child: _StayEmptyStateContent(imagePath: imagePath, imageSize: 210),
      ),
    );
  }
}

class _StayMapEmptyState extends StatelessWidget {
  const _StayMapEmptyState({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: _StayEmptyStateContent(imagePath: imagePath, imageSize: 132),
      ),
    );
  }
}

class _StayEmptyStateContent extends StatelessWidget {
  const _StayEmptyStateContent({
    required this.imagePath,
    required this.imageSize,
  });

  final String imagePath;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 24),
        const Text(
          'Нет подходящих вариантов',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1A1B1C),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Попробуйте изменить параметры поиска',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1A1B1C),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _GeoapifyStayMap extends StatefulWidget {
  const _GeoapifyStayMap({
    required this.stays,
    required this.selectedIndex,
    required this.onPinTap,
  });

  final List<_StayCardData> stays;
  final int? selectedIndex;
  final ValueChanged<int> onPinTap;

  @override
  State<_GeoapifyStayMap> createState() => _GeoapifyStayMapState();
}

class _GeoapifyStayMapState extends State<_GeoapifyStayMap> {
  final MapController _mapController = MapController();
  final LatLng _defaultCenter = const LatLng(55.7558, 37.6173);
  final double _minZoom = 3;
  final double _maxZoom = 18;
  LatLng _currentCenter = const LatLng(55.7558, 37.6173);
  double _currentZoom = 10.5;

  void _updateMapPosition(MapCamera camera, bool hasGesture) {
    _currentCenter = camera.center;
    _currentZoom = camera.zoom;
  }

  void _zoomIn() {
    final newZoom = (_currentZoom + 1).clamp(_minZoom, _maxZoom);
    if (newZoom == _currentZoom) {
      return;
    }

    _currentZoom = newZoom;
    _mapController.move(_currentCenter, _currentZoom);
  }

  void _zoomOut() {
    final newZoom = (_currentZoom - 1).clamp(_minZoom, _maxZoom);
    if (newZoom == _currentZoom) {
      return;
    }

    _currentZoom = newZoom;
    _mapController.move(_currentCenter, _currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    const geoapifyApiKey = String.fromEnvironment('GEOAPIFY_API_KEY');

    if (geoapifyApiKey.isEmpty) {
      return const _MapTokenEmptyState();
    }

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            // Москва как временный центр карты, дальше будем брать координаты из БД.
            initialCenter: _defaultCenter,
            initialZoom: _currentZoom,
            minZoom: _minZoom,
            maxZoom: _maxZoom,
            onPositionChanged: _updateMapPosition,
            interactionOptions: InteractionOptions(
              // Масштабирование теперь доступно и жестами, и кнопками.
              flags:
                  InteractiveFlag.drag |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.pinchMove |
                  InteractiveFlag.doubleTapZoom |
                  InteractiveFlag.scrollWheelZoom |
                  InteractiveFlag.flingAnimation,
              enableMultiFingerGestureRace: true,
              pinchZoomThreshold: 0.01,
              pinchMoveThreshold: 0,
              scrollWheelVelocity: 0.01,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=$geoapifyApiKey',
              userAgentPackageName: 'com.example.booking',
              maxNativeZoom: 20,
              keepBuffer: 4,
              tileDisplay: const TileDisplay.instantaneous(),
              tileProvider: NetworkTileProvider(
                cachingProvider: BuiltInMapCachingProvider.getOrCreateInstance(
                  maxCacheSize: 500 * 1024 * 1024,
                  overrideFreshAge: Duration(days: 30),
                ),
              ),
            ),
            if (widget.stays.isNotEmpty)
              MarkerLayer(
                markers: List.generate(widget.stays.length, (index) {
                  final stay = widget.stays[index];
                  return Marker(
                    point: stay.coordinates,
                    width: 96,
                    height: 40,
                    child: Center(
                      child: _MapPricePin(
                        label: stay.totalPrice,
                        isSelected: widget.selectedIndex == index,
                        onTap: () => widget.onPinTap(index),
                      ),
                    ),
                  );
                }),
              ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'Geoapify | OpenMapTiles | OpenStreetMap',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 24,
          right: 24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MapZoomButton(
                icon: Icons.add,
                onTap: _zoomIn,
                isEnabled: _currentZoom < _maxZoom,
              ),
              const SizedBox(height: 12),
              _MapZoomButton(
                icon: Icons.remove,
                onTap: _zoomOut,
                isEnabled: _currentZoom > _minZoom,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapTokenEmptyState extends StatelessWidget {
  const _MapTokenEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEDE9DF),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: const Text(
        'Для карты нужен GEOAPIFY_API_KEY',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF525252),
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
      ),
    );
  }
}

class _MapZoomButton extends StatelessWidget {
  const _MapZoomButton({
    required this.icon,
    required this.onTap,
    required this.isEnabled,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: const CircleBorder(),
            shadows: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 24,
            color: isEnabled ? const Color(0xFFF88A2A) : const Color(0xFFB5A38C),
          ),
        ),
      ),
    );
  }
}

class _MapPricePin extends StatelessWidget {
  const _MapPricePin({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFF88A2A) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [BoxShadow(color: Color(0x19000000), blurRadius: 32)],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1A1B1C),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _MapStayCard extends StatelessWidget {
  const _MapStayCard({required this.data, required this.onClose});

  final _StayCardData data;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 24)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 345 / 218,
                  child: Image.asset(data.imagePath, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 20,
                  right: 66,
                  child: _MapCardCircleButton(
                    icon: data.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: data.isFavorite
                        ? const Color(0xFFF88A2A)
                        : const Color(0xFF1A1B1C),
                    onTap: () {},
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: _MapCardCircleButton(
                    icon: Icons.close_rounded,
                    color: const Color(0xFF1A1B1C),
                    onTap: onClose,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 14,
                  child: _PhotoIndicator(activeIndex: data.activePhotoIndex),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: _StayCardDetails(data: data),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapCardCircleButton extends StatelessWidget {
  const _MapCardCircleButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

class _StayCard extends StatelessWidget {
  const _StayCard({required this.data});

  final _StayCardData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 345 / 220,
                child: Image.asset(data.imagePath, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  data.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: data.isFavorite
                      ? const Color(0xFFF88A2A)
                      : const Color(0xFF1A1B1C),
                  size: 24,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 14,
              child: _PhotoIndicator(activeIndex: data.activePhotoIndex),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _StayCardDetails(data: data),
      ],
    );
  }
}

class _StayCardDetails extends StatelessWidget {
  const _StayCardDetails({required this.data});

  final _StayCardData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                data.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF1A1B1C),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.rating,
                  style: const TextStyle(
                    color: Color(0xFF1A1B1C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFF88A2A),
                  size: 20,
                ),
                Text(
                  '(${data.reviews})',
                  style: const TextStyle(
                    color: Color(0xFF1A1B1C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 18,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _StayMetaItem(icon: Icons.location_on_outlined, label: data.city),
            _StayMetaItem(icon: Icons.home_outlined, label: data.type),
            _StayMetaItem(
              icon: Icons.calendar_today_outlined,
              label: '${data.dates} · ${data.nights}',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              data.totalPrice,
              style: const TextStyle(
                color: Color(0xFF1A1B1C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                data.nightPrice,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF1A1B1C),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StayMetaItem extends StatelessWidget {
  const _StayMetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFF88A2A), size: 16),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF89919D),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _PhotoIndicator extends StatelessWidget {
  const _PhotoIndicator({required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isActive ? 16 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : const Color(0xFFE2E5EA),
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }),
    );
  }
}

class _StayCardData {
  const _StayCardData({
    required this.title,
    required this.city,
    required this.type,
    required this.dates,
    required this.nights,
    required this.totalPrice,
    required this.nightPrice,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    required this.isFavorite,
    required this.activePhotoIndex,
    required this.coordinates,
  });

  final String title;
  final String city;
  final String type;
  final String dates;
  final String nights;
  final String totalPrice;
  final String nightPrice;
  final String rating;
  final String reviews;
  final String imagePath;
  final bool isFavorite;
  final int activePhotoIndex;
  final LatLng coordinates;
}
