import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';
import 'package:mosque_finder_app/feature/event/presentation/widgets/hijri_calender_widget.dart';

import '../../models/event_mock_data.dart';
import '../../models/event_model.dart';
import '../pages/event_detail_page.dart';
import '../widgets/category_chips.dart';
import '../widgets/event_card.dart';
import '../widgets/events_header.dart';

// ═════════════════════════════════════════════════════════════════════════════
// EVENTS SCREEN
// ═════════════════════════════════════════════════════════════════════════════

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<Event> _events = buildEvents();
  String _selectedCategory = 'all';
  final int _selectedDay = 8; // today
  bool _showCalendar = true;

  List<Event> get _filteredEvents {
    return _selectedCategory == 'all'
        ? _events
        : _events.where((e) => e.categoryId == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: EventsHeader(
              showCalendar: _showCalendar,
              onToggleCalendar: () =>
                  setState(() => _showCalendar = !_showCalendar),
            ),
          ),
          SliverToBoxAdapter(
            child: CategoryChips(
              categories: categories,
              selectedCategory: _selectedCategory,
              onCategoryChanged: (catId) =>
                  setState(() => _selectedCategory = catId),
            ),
          ),

          if (_showCalendar)
            SliverToBoxAdapter(
              // child: CalendarCard(
              //   selectedDay: _selectedDay,
              //   onDaySelected: (day) => setState(() => _selectedDay = day),
              // ),
              child: HijriCalendarWidget(
                primaryColor: AppColors.kPrimary,
                cardColor: AppColors.kCard,
                borderColor: AppColors.kBorder,
                textColor: AppColors.kText,
                subTextColor: AppColors.kSubText,
                showArabicToggle: true,
                showDetailStrip: true,
                onDaySelected: (greg, hijri) {},
              ),
            ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      color: AppColors.kText,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_filteredEvents.length} events',
                    style: const TextStyle(
                      color: AppColors.kSubText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
       
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => EventCard(
                event: _filteredEvents[index],
                onRsvp: () => setState(
                  () => _filteredEvents[index].rsvpd =
                      !_filteredEvents[index].rsvpd,
                ),
                onTap: () => _openEventDetail(_filteredEvents[index]),
              ),
              childCount: _filteredEvents.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  void _openEventDetail(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
    );
  }
}
