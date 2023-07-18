import 'dart:math';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/view/settings/settings_view.dart';

import '../../common_widget/subscription_cell.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  CalendarAgendaController calendarAgendaControllerNotAppBar =
      CalendarAgendaController();
  late DateTime selectedDateNotAppBBar;

  Random random = new Random();

  List subArr = [
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png", "price": "5.99"},
    {
      "name": "YouTube Premium",
      "icon": "assets/img/youtube_logo.png",
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
      "price": "29.99"
    },
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png", "price": "15.00"}
  ];

    @override
  void initState() {
    super.initState();
    selectedDateNotAppBBar = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Calender",
                                    style: TextStyle(
                                        color: TColor.gray30, fontSize: 16),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView() ) );
                                      },
                                      icon: Image.asset("assets/img/settings.png",
                                          width: 25,
                                          height: 25,
                                          color: TColor.gray30))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Subs\nSchedule",
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "3 subscription for today",
                                style: TextStyle(
                                    color: TColor.gray30,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  calendarAgendaControllerNotAppBar.openCalender();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: TColor.border.withOpacity(0.1),
                                    ),
                                    color: TColor.gray60.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Text(
                                        "January",
                                        style: TextStyle(
                                            color: TColor.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.expand_more, color: TColor.white,
                                        size: 16.0,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    CalendarAgenda(
                      controller: calendarAgendaControllerNotAppBar,
                     backgroundColor: Colors.transparent,
                     fullCalendarBackgroundColor: TColor.gray80,
                      
                      locale: 'en',
                      weekDay: WeekDay.short,
                      fullCalendarDay: WeekDay.short,
                      selectedDateColor: TColor.white,
                      initialDate: DateTime.now(),
                      calendarEventColor: TColor.secondary,
                      firstDate: DateTime.now().subtract(const Duration(days: 140)),
                      lastDate: DateTime.now().add(const Duration(days: 140)),
                      events: List.generate(
                          100,
                          (index) => DateTime.now().subtract(
                              Duration(days: index * random.nextInt(5)))),
                      onDateSelected: (date) {
                        setState(() {
                          selectedDateNotAppBBar = date;
                        });
                      },

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: TColor.border.withOpacity(0.15),
                        ),
                        color: TColor.gray60.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      selectDecoration: BoxDecoration(
                        border: Border.all(
                          color: TColor.border.withOpacity(0.15),
                        ),
                        color: TColor.gray60,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      selectedEventLogo: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: TColor.secondary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      eventLogo: Container(
                        width: 5,
                        height: 5,
                        decoration:  BoxDecoration(
                          
                          color: TColor.secondary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "January",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$24.98",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "01.08.2023",
                        style: TextStyle(
                            color: TColor.gray30,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "in upcoming bills",
                        style: TextStyle(
                            color: TColor.gray30,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1),
                itemCount: subArr.length,
                itemBuilder: (context, index) {
                  var sObj = subArr[index] as Map? ?? {};

                  return SubScriptionCell(
                    sObj: sObj,
                    onPressed: () {},
                  );
                }),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
