import 'package:flutter/material.dart';

class addScreen extends StatelessWidget {

  String page = 'add';

  addScreen({required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  title: page=='add'? Text('add todo'):Text('Edit todo'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: (){
                        _datePickerDialog(context);
                      },
                      decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      onTap: (){
                        _timerDialog(context);
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: page == 'add' ? Text('Add') :Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String text, String ans,BuildContext context) {
    final SnackBar snackBar = SnackBar(
        duration: const Duration(milliseconds: 500),
        backgroundColor:
        ans.compareTo('Yes') == 0 ? Colors.green : Colors.red,
        content: Row(
          children: <Widget>[
            Icon(
              ans.compareTo('Yes') == 0 ? Icons.favorite : Icons.watch_later,
              color: ans.compareTo('Yes') == 0 ? Colors.pink : Colors.yellow,
              size: 24.0,
              semanticLabel: text,
            ),
            Text(text)
          ],
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _datePickerDialog(BuildContext context) {
    final DateTime now = DateTime.now();
    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050))
        .then((DateTime? onValue) {
         _showSnackBar('$onValue', 'ok',context);
    });
  }

  void _timerDialog(BuildContext context) {
    final DateTime now = DateTime.now();
    showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((TimeOfDay? onValue) {
     _showSnackBar(onValue?.format(context) ?? '', 'ok',context);
    });
  }

}
