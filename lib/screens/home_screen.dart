import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p_17_date/models/event.dart';
import 'package:p_17_date/register/singup.dart';
import 'package:p_17_date/screens/todo_screen.dart';
import 'package:p_17_date/screens/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class homeScreen extends StatefulWidget {
  String page;


  homeScreen({required this.page});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final TextEditingController _eventController = TextEditingController();
  int index = 1;

  @override
  void initState() async{
    // TODO: implement initState
    super.initState();
    await  birthDay();
    selectedEvents = {};
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _eventController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date'),
        actions: [IconButton(onPressed: (){
          birthDay();
        }, icon:Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              eventLoader: _getEventsfromDay,
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 0.7,
              height: 0.7,
            ),

            ..._getEventsfromDay(selectedDay).map(
              (Event event) => ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Edit Event',
                      ),
                      content: TextField(
                        controller: _eventController,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_eventController.text.isEmpty) {
                              Navigator.pop(context);
                              return;
                            } else {
                              if (selectedEvents[selectedDay] != null) {
                                selectedEvents[selectedDay]?.add(
                                  Event(title: _eventController.text),
                                );
                              } else {
                                selectedEvents[selectedDay] = [
                                  Event(title: _eventController.text)
                                ];
                              }
                            }
                            Navigator.pop(context);
                            _eventController.clear();
                            setState(() {});
                            return;
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                },
                title: Text(event.title),
                trailing: IconButton(
                  onPressed: () {
                    selectedEvents[selectedDay]
                        ?.remove(Event(title: _eventController.text));
                  },
                  icon: const Icon(Icons.remove),
                ),
              ),
            ),

            // FutureBuilder(
            //   future: Hive.openBox('Event'),
            //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //     if (snapshot.hasData ||
            //         snapshot.connectionState == ConnectionState.done) {
            //       var openBox = Hive.box('Event');
            //       return ValueListenableBuilder(
            //         valueListenable: openBox.listenable(),
            //         builder: (BuildContext context, Box box, Widget? child) {
            //           if(box.values.isEmpty){
            //
            //             return Text('not found') ;
            //
            //           }else {
            //             return ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: openBox.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 Event eventBox = box.getAt(index);
            //                 return ListTile(
            //                   onTap: () {
            //                     showDialog(
            //                       context: context,
            //                       builder: (context) =>
            //                           AlertDialog(
            //                             title: const Text(
            //                               'Edit Event',
            //                             ),
            //                             content: TextField(
            //                               controller: _eventController,
            //                             ),
            //                             actions: [
            //                               TextButton(
            //                                 onPressed: () =>
            //                                     Navigator.pop(context),
            //                                 child: const Text('Cancel'),
            //                               ),
            //                               TextButton(
            //                                 onPressed: () {
            //                                   if (_eventController.text
            //                                       .isEmpty) {
            //                                     Navigator.pop(context);
            //                                     return;
            //                                   } else {
            //                                     if (selectedEvents[selectedDay] !=
            //                                         null) {
            //                                       selectedEvents[selectedDay]
            //                                           ?.add(
            //                                         Event(
            //                                             title: _eventController
            //                                                 .text),
            //                                       );
            //                                     } else {
            //                                       selectedEvents[selectedDay] =
            //                                       [
            //                                         Event(
            //                                             title: _eventController
            //                                                 .text)
            //                                       ];
            //                                     }
            //                                   }
            //                                   Navigator.pop(context);
            //                                   _eventController.clear();
            //                                   setState(() {});
            //                                   return;
            //                                 },
            //                                 child: const Text('Ok'),
            //                               ),
            //                             ],
            //                           ),
            //                     );
            //                   },
            //                   title: Text(eventBox.title),
            //                   trailing: IconButton(
            //                     onPressed: () {
            //                       selectedEvents[selectedDay]
            //                           ?.remove(
            //                           Event(title: _eventController.text));
            //                    //   print(selectedDay);
            //                       delete(index);
            //                     },
            //                     icon: const Icon(Icons.remove),
            //                   ),
            //                 );
            //               },
            //             );
            //           }
            //
            //         },
            //       );
            //     } else {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Add Event',
            ),
            content: TextField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Event event = Event(title: '-1');
                  final box = Hive.openBox('event');
                  print(box);
                  if (_eventController.text.isEmpty) {
                    Navigator.pop(context);
                    return;
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                      add();
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                      add();
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
        label: const Text(
          'Add Event',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 150, bottom: 30),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Get.to(todoScreen());
              },
              title: const Text('Todo'),
              trailing: const Icon(Icons.today_outlined),
            ),
            const Divider(
              height: 0.5,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                if (widget.page == 'Guest') {
                  Navigator.pop(context);

                  final snackBar = SnackBar(
                    content: const Text('Register to view !'),
                    action: SnackBarAction(
                      label: 'SingUp',
                      onPressed: () {
                        Get.off(SingUp());
                      },
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Get.to(const Weather());
                }
              },
              title: const Text('Weather news'),
              trailing: const Icon(Icons.wb_cloudy_outlined),
            ),
            const Divider(
              height: 0.5,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                );
              },
              title: const Text('Theme'),
              trailing: const Icon(Icons.color_lens_outlined),
            ),
            const Divider(
              height: 0.5,
              thickness: 0.5,
            ),
            ListTile(
              onTap: () {
                alertDialog();
                //  Get.defaultDialog();
              },
              title: const Text('Logout'),
              trailing: const Icon(Icons.exit_to_app),
            ),
            const Divider(
              height: 0.5,
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> alertDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Warning'),
            content: const Text('Cupertino Dialog, Is it nice?'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'Yes');
                },
                child: const Text('Yes'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'No');
                },
                child: const Text('No'),
              ),
            ],
          );
        })) {
      case 'Yes':
        SystemNavigator.pop();
        // _showSnackBar('Thanks!', 'Yes',context);
        break;
      case 'No':
        Get.back();
        break;
    }
  }

  void add() async {
    var box = await Hive.openBox('Event');
    Event event = Event(title: _eventController.text);
    var result = await box.add(event);
    print(result);
  }

  void update(index) async {
    var box = await Hive.openBox('Event');
    Event event = Event(title: _eventController.text);
    //await box.putAt(index);
  }

  void delete(int index) async {
    var box = await Hive.openBox('Event');
    Event event = Event(title: _eventController.text);
    await box.deleteAt(index);
  }

  birthDay() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String datebirth = await pref.getString('data') ?? '';
    String full = await pref.getString('full') ?? '';
    var date = DateTime.now().toString().substring(0, 11);
    print(date);
    print(datebirth);
    if (date == datebirth) {

      Get.snackbar('Hello', 'Happy Birthday $full');

    }
  }

}
