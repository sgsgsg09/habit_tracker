import 'package:flutter/material.dart';
import 'package:habits_tracker/views/habit_widgets/overall_tab.dart';
import 'package:habits_tracker/views/habit_widgets/today_tab.dart';
import 'package:habits_tracker/views/habit_widgets/weekly_list_widget.dart';
import 'package:habits_tracker/resource/message/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(context).textTheme.displayLarge,
        title: Text(Messages.of(context).appBarTitle),
        /* actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            color: AppPalette.textPrimary,
            onPressed: () {},
          )
        ], */
        bottom: TabBar(
          controller: _tabController,
          labelStyle: Theme.of(context).textTheme.displaySmall,
          tabs: [
            Tab(text: Messages.of(context).tabToday),
            Tab(text: Messages.of(context).tabWeekly),
            Tab(text: Messages.of(context).tabOverall),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TodayTab(),
          WeeklyTab(),
          OverallTab(),
        ],
      ),
    );
  }
}
