import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:p_17_date/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p_17_date/register/singin.dart';

import '../screens/home_screen.dart';

class SingUp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  late Size size;
  late String _value;
  late DateTime _dateTime;
  bool flag = true;
  late TextEditingController FNconteroler;
  late TextEditingController USconteroler;
  late TextEditingController Passconteroler;
  late TextEditingController REPassconteroler;
  late TextEditingController DATEconteroler;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    FNconteroler = TextEditingController();
    USconteroler = TextEditingController();
    Passconteroler = TextEditingController();
    REPassconteroler = TextEditingController();
    DATEconteroler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    FNconteroler.dispose();
    USconteroler.dispose();
    Passconteroler.dispose();
    REPassconteroler.dispose();
    DATEconteroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.36,
                    child: TextFormField(
                      controller: FNconteroler,
                      validator: (m) {
                        if (m == '') {
                          return 'Please enter your Full name';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        label: Text(
                          'Full name',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: size.width * 0.36,
                    child: TextFormField(
                      controller: USconteroler,
                      validator: (m) {
                        if (m == '') {
                          return 'Please enter your User name';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        label: Text(
                          'User name',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                width: size.width * 0.75,
                child: TextFormField(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1925),
                      lastDate: DateTime(2050),
                    ).then((Date) {
                      final date = Date.toString().substring(0, 11);
                      DATEconteroler.text = date;
                    });
                  },
                  controller: DATEconteroler,
                  validator: (m) {
                    if (m == '') {
                      return 'Please enter your Date of birth';
                    } else if (DATEconteroler.text.substring(7, 11).length !=
                        4) {
                      return 'The entered template is incorrect';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    label: Text(
                      'Date of birth (MM/DD/YYYY)',
                      style: TextStyle(color: Colors.grey),
                    ),
                    icon: Icon(Icons.date_range_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                width: size.width * 0.75,
                child: TextFormField(
                  controller: Passconteroler,
                  validator: (m) {
                    if (m == '') {
                      return 'Please enter your Password';
                    } else if (m!.length < 6) {
                      return 'The number of characters entered is less than 6';
                    } else {
                      return null;
                    }
                  },
                  obscureText: flag,
                  decoration: InputDecoration(
                    label: const Text(
                      'Password',
                      style: TextStyle(color: Colors.grey),
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(flag == false
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          flag = !flag;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                width: size.width * 0.75,
                child: TextFormField(
                  controller: REPassconteroler,
                  validator: (m) {
                    if (m == '') {
                      return 'Please enter your Password';
                    } else if (m!.length < 6) {
                      return 'The number of characters entered is less than 6';
                    } else {
                      return null;
                    }
                  },
                  obscureText: flag,
                  decoration: InputDecoration(
                    label: const Text(
                      'Password retype',
                      style: TextStyle(color: Colors.grey),
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(flag == false
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          flag = !flag;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.white, // background
                  minimumSize: Size(size.width * 0.75, 40),
                ),
                onPressed: () {
                  add();
                  printer();
                  if (validation()) {
                    if (Passconteroler.text == REPassconteroler.text) {
                      Get.off(
                        homeScreen(
                          page: 'Register',
                          birthday: DATEconteroler.text,
                        ),
                      );
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('The password is different !'),
                        action: SnackBarAction(
                          label: 'Warning',
                          onPressed: () {
                            //
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    print('no');
                  }
                },
                child: const Text(
                  'SINGUP',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => SingIn()));
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => SingIn()));
                    Get.off(SingIn());
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.grey),
                  )),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validation() {
    FormState? _form = _formkey.currentState;
    if (_form!.validate()) return true;
    return false;
  }

  //print name & family
  void printer() {
    var fullname = FNconteroler.text;
    var user = USconteroler.text;
    var pass = Passconteroler.text;
    var date = DATEconteroler.text;
    print('$fullname $user $pass $date');
  }
  add() async {

   SharedPreferences pref =await SharedPreferences.getInstance();

   await pref.setString('full', FNconteroler.text);
   await pref.setString('data', DATEconteroler.text);
   await pref.setString('user', USconteroler.text);


   if (Passconteroler.text == REPassconteroler.text) {
     await pref.setString('pass', Passconteroler.text);
   }
  }
}
