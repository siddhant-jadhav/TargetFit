import 'package:flutter/material.dart';

void main() {
  runApp(const FitTargetApp());
}

/// Root Application Widget with a clean, minimalistic light theme.
class FitTargetApp extends StatelessWidget {
  const FitTargetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTarget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5252),
          primary: const Color(0xFF1E293B),
          secondary: const Color(0xFFFF5252),
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0.5,
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xFF1E293B)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
      home: const FitTargetMainScreen(),
    );
  }
}

/// Main Screen with Bottom Navigation Bar holding the 3 tabs:
/// Home, Schedule, and History.
class FitTargetMainScreen extends StatefulWidget {
  const FitTargetMainScreen({super.key});

  @override
  State<FitTargetMainScreen> createState() => _FitTargetMainScreenState();
}

class _FitTargetMainScreenState extends State<FitTargetMainScreen> {
  int _currentNavIndex = 0;

  Widget _buildAppBarTitle() {
    if (_currentNavIndex == 1) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5252).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_month_rounded,
              color: Color(0xFFFF5252),
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Schedule',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      );
    } else if (_currentNavIndex == 2) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5252).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.history_rounded,
              color: Color(0xFFFF5252),
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'History',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: const Color(0xFFFF5252).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.local_fire_department_rounded,
            color: Color(0xFFFF5252),
            size: 22,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'FitTarget',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top App Bar with App Name / Tab Name and Profile Icon
      appBar: AppBar(
        titleSpacing: 20,
        title: _buildAppBarTitle(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFE2E8F0),
                  child: Icon(
                    Icons.person_rounded,
                    color: Color(0xFF475569),
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Body switching between pages
      body: IndexedStack(
        index: _currentNavIndex,
        children: const [
          HomePageView(),
          SchedulePageView(),
          HistoryPageView(),
        ],
      ),

      // Bottom Navigation Bar with Home, Schedule, and History
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: NavigationBar(
          selectedIndex: _currentNavIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentNavIndex = index;
            });
          },
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFFF5252).withValues(alpha: 0.12),
          elevation: 0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0xFF64748B)),
              selectedIcon: Icon(Icons.home_rounded, color: Color(0xFFFF5252)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined, color: Color(0xFF64748B)),
              selectedIcon: Icon(Icons.calendar_month_rounded, color: Color(0xFFFF5252)),
              label: 'Schedule',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined, color: Color(0xFF64748B)),
              selectedIcon: Icon(Icons.history_rounded, color: Color(0xFFFF5252)),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// PAGE 1: HOME PAGE VIEW
// ==========================================
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  // Weekly calorie data (kcal)
  final List<DailyCalorieData> _weeklyData = const [
    DailyCalorieData(day: 'Mon', calories: 1850, isTargetMet: true),
    DailyCalorieData(day: 'Tue', calories: 2100, isTargetMet: true),
    DailyCalorieData(day: 'Wed', calories: 1450, isTargetMet: false),
    DailyCalorieData(day: 'Thu', calories: 2300, isTargetMet: true),
    DailyCalorieData(day: 'Fri', calories: 1950, isTargetMet: true),
    DailyCalorieData(day: 'Sat', calories: 2450, isTargetMet: true),
    DailyCalorieData(day: 'Sun', calories: 1600, isTargetMet: false),
  ];

  int _selectedDayIndex = 5; // Saturday selected by default
  final double _dailyCalorieTarget = 1800; // Target kcal line

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        // 1. Header Greeting & Date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Athlete 👋',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Daily Calorie Target',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey.shade700),
                  const SizedBox(width: 6),
                  Text(
                    'This Week',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Weekly Calorie Bar Graph Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Metrics',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Calories burned per day',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  // Legend
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5252),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Target Met',
                        style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Bar Graph
              SizedBox(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(_weeklyData.length, (index) {
                    final item = _weeklyData[index];
                    final isSelected = index == _selectedDayIndex;
                    const maxGraphCalories = 2600.0;
                    final barHeightFactor = (item.calories / maxGraphCalories).clamp(0.08, 1.0);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDayIndex = index;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Calorie tooltip/label if selected
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: isSelected ? 1.0 : 0.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${item.calories.toInt()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // The actual Bar
                          Container(
                            width: 28,
                            height: 120 * barHeightFactor,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFF5252)
                                  : (item.isTargetMet
                                      ? const Color(0xFFFF8A80).withValues(alpha: 0.65)
                                      : Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFFF5252).withValues(alpha: 0.35),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Day Label
                          Text(
                            item.day,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const Divider(height: 24, thickness: 0.8),

              // Average summary note
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Average: 1,957 kcal',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'Target: ${_dailyCalorieTarget.toInt()} kcal',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF5252),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

/// Helper Model for Daily Calorie Metrics
class DailyCalorieData {
  final String day;
  final double calories;
  final bool isTargetMet;

  const DailyCalorieData({
    required this.day,
    required this.calories,
    required this.isTargetMet,
  });
}

// ==========================================
// PAGE 2: SCHEDULE PAGE VIEW
// ==========================================
class ScheduledExercise {
  String name;
  String repetitions;
  IconData icon;
  bool isCompleted;

  ScheduledExercise({
    required this.name,
    required this.repetitions,
    this.icon = Icons.fitness_center_rounded,
    this.isCompleted = false,
  });
}

class SchedulePageView extends StatefulWidget {
  const SchedulePageView({super.key});

  @override
  State<SchedulePageView> createState() => _SchedulePageViewState();
}

class _SchedulePageViewState extends State<SchedulePageView> {
  // 4 Default Exercises
  final List<ScheduledExercise> _exercises = [
    ScheduledExercise(
      name: 'Push Ups',
      repetitions: '3 sets • 15 reps',
      icon: Icons.fitness_center_rounded,
      isCompleted: false,
    ),
    ScheduledExercise(
      name: 'Squats',
      repetitions: '4 sets • 12 reps',
      icon: Icons.directions_run_rounded,
      isCompleted: false,
    ),
    ScheduledExercise(
      name: 'Pull Ups',
      repetitions: '3 sets • 10 reps',
      icon: Icons.sports_gymnastics_rounded,
      isCompleted: false,
    ),
    ScheduledExercise(
      name: 'Plank Hold',
      repetitions: '3 sets • 60 secs',
      icon: Icons.timer_outlined,
      isCompleted: false,
    ),
  ];

  String _getFormattedDate() {
    final now = DateTime.now();
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${weekdays[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
  }

  void _showAddCustomDialog() {
    final nameController = TextEditingController();
    final repsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Custom Exercise',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Exercise Name',
                    hintText: 'e.g. Bench Press, Lunges, Deadlift',
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFFF5252), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: repsController,
                  decoration: InputDecoration(
                    labelText: 'Sets & Repetitions',
                    hintText: 'e.g. 3 sets • 12 reps',
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFFF5252), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5252),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      final name = nameController.text.trim();
                      final reps = repsController.text.trim();
                      if (name.isNotEmpty) {
                        setState(() {
                          _exercises.add(
                            ScheduledExercise(
                              name: name,
                              repetitions: reps.isNotEmpty ? reps : '3 sets • 10 reps',
                              icon: Icons.fitness_center_rounded,
                              isCompleted: false,
                            ),
                          );
                        });
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Text(
                      'Add Exercise',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _exercises.where((e) => e.isCompleted).length;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        // 1. Date Header Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TODAY\'S WORKOUT',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: Color(0xFFFF5252),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _getFormattedDate(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 15,
                    color: Color(0xFFFF5252),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$completedCount/${_exercises.length} Done',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // 2. 4 Horizontal Exercise Bars
        ..._exercises.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return _buildExerciseCard(item, index);
        }),

        // 3. 5th Horizontal Bar: Custom Exercise Add Button
        _buildAddCustomCard(),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildExerciseCard(ScheduledExercise item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isCompleted
              ? const Color(0xFFFF5252).withValues(alpha: 0.35)
              : Colors.grey.shade200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            setState(() {
              item.isCompleted = !item.isCompleted;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Exercise Icon Badge
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item.isCompleted
                        ? const Color(0xFFFF5252).withValues(alpha: 0.12)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.isCompleted
                        ? const Color(0xFFFF5252)
                        : const Color(0xFF475569),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),

                // Exercise Title & Repetitions
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: item.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: item.isCompleted
                              ? Colors.grey.shade500
                              : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.repetitions,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: item.isCompleted
                              ? Colors.grey.shade400
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),

                // Checkbox
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    value: item.isCompleted,
                    activeColor: const Color(0xFFFF5252),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.5,
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        item.isCompleted = value ?? false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddCustomCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFF5252).withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _showAddCustomDialog,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5252).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Color(0xFFFF5252),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '+ add custom',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFF5252),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Tap to add your own exercise & reps',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF5252).withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFFFF5252),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PAGE 3: HISTORY PAGE VIEW
// ==========================================
class HistoryItem {
  final String date;
  final String workoutDuration;
  final List<String> exercises;
  final int caloriesBurned;

  const HistoryItem({
    required this.date,
    required this.workoutDuration,
    required this.exercises,
    required this.caloriesBurned,
  });
}

class HistoryPageView extends StatelessWidget {
  const HistoryPageView({super.key});

  // 3 History entries
  final List<HistoryItem> _historyItems = const [
    HistoryItem(
      date: 'Yesterday, 1 Sep',
      workoutDuration: '45 mins • Upper Body',
      exercises: ['Push Ups • 3 sets', 'Pull Ups • 3 sets', 'Bench Press • 4 sets', 'Plank • 3 mins'],
      caloriesBurned: 2100,
    ),
    HistoryItem(
      date: 'Monday, 31 Aug',
      workoutDuration: '50 mins • Lower Body & Cardio',
      exercises: ['Squats • 4 sets', 'Cycling • 30 mins', 'Walking • 5,000 steps', 'Lunges • 3 sets'],
      caloriesBurned: 1850,
    ),
    HistoryItem(
      date: 'Sunday, 30 Aug',
      workoutDuration: '60 mins • Full Body & Core',
      exercises: ['Running • 5 km', 'Push Ups • 4 sets', 'Squats • 3 sets', 'Core Workout • 15 mins'],
      caloriesBurned: 2450,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        // Header Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PAST SESSIONS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: Color(0xFFFF5252),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Workout History',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.history_rounded, size: 14, color: Color(0xFFFF5252)),
                  const SizedBox(width: 6),
                  Text(
                    '${_historyItems.length} Sessions',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // 3 Untappable Rounded Rectangles
        ..._historyItems.map((item) => _buildHistoryCard(item)),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHistoryCard(HistoryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Date & Calories burned badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5252).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.event_note_rounded,
                      color: Color(0xFFFF5252),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.date,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        item.workoutDuration,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Calories Burned
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5252).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      size: 16,
                      color: Color(0xFFFF5252),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${item.caloriesBurned} kcal',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF5252),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 0.8),
          ),

          // Exercises Section
          const Text(
            'Exercises Completed',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: item.exercises.map((exercise) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 14,
                      color: Color(0xFF10B981),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      exercise,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// PAGE 4: PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Profile Avatar & Name
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF5252).withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 44,
                    backgroundColor: Color(0xFFE2E8F0),
                    child: Icon(
                      Icons.person_rounded,
                      size: 52,
                      color: Color(0xFF475569),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'siddhant',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fitness Member',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Streak Card with fire icon
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5252), Color(0xFFFF7A59)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5252).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '7 Days Streak 🔥',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'You are on fire! Keep it going',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Details List: name, age, height, weight
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildProfileDetailRow(
                  label: 'name',
                  value: 'siddhant',
                  icon: Icons.person_outline_rounded,
                ),
                const Divider(height: 24, thickness: 0.8),
                _buildProfileDetailRow(
                  label: 'age',
                  value: '20',
                  icon: Icons.cake_outlined,
                ),
                const Divider(height: 24, thickness: 0.8),
                _buildProfileDetailRow(
                  label: 'height',
                  value: '183cm',
                  icon: Icons.height_rounded,
                ),
                const Divider(height: 24, thickness: 0.8),
                _buildProfileDetailRow(
                  label: 'weight',
                  value: '75kg',
                  icon: Icons.monitor_weight_outlined,
                ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Version text below
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'FitTarget • Build 2026.1',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileDetailRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 14),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
