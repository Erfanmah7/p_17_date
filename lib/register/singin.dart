import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p_17_date/models/todo.dart';
import 'package:p_17_date/register/singup.dart';
import 'package:p_17_date/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingIn extends StatefulWidget {
  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  late Size size;
  bool flag = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingIn'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 1,
                ),
                Container(
                  width: size.width * 0.75,
                  child: TextFormField(
                    controller: userController,
                    validator: (m) {
                      if (m == '') {
                        return 'Please enter your user';
                      } else if (m!.length < 6) {
                        return 'The number of characters entered is less than 6';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text(
                        'User',
                        style: TextStyle(color: Colors.grey),
                      ),
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Container(
                  width: size.width * 0.75,
                  child: TextFormField(
                    controller: passController,
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
                  height: 30,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white, // background
                    minimumSize: Size(size.width * 0.75, 40),
                  ),
                  onPressed: () async{
                    if (validation()) {
                      isUser();
                   bool rrr = await add();
                   if(rrr){

                     Get.off(
                       homeScreen(
                           page: 'Login',
                        ),
                     );

                   }else{

                       final snackBar = SnackBar(
                         content: const Text('The information entered is incorrect !!!'),
                         action: SnackBarAction(
                           label: 'Error',
                           onPressed: () {

                           },
                         ),
                       );

                       // Find the ScaffoldMessenger in the widget tree
                       // and use it to show a SnackBar.
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);


                   }


                    } else {
                      print('no');
                    }
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(builder: (context) => SingUp(),),);

                        Get.off(SingUp());
                      },
                      child: const Text(
                        'SingUp',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 500,
                    ),
                    InkWell(
                        onTap: () {
                          Get.off(homeScreen(
                            page: 'Guest',
                          ));
                        },
                        child: const Text(
                          'Guest arrival',
                          style: TextStyle(color: Colors.grey),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validation() {
    FormState? _form = _formkey.currentState;
    if (_form!.validate()) {
      print('yes');
      return true;
    } else {
      print('no');
      return false;
    }
  }

  isUser() async {
    Box box = await Hive.openBox('todo');
    // todo userobj = todo();
    todo user = box.get('user');
    print(user);
    todo password = box.get('password');
    print(password);
  }

 Future<bool> add() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String user = await pref.getString('user') ?? '';
    String pass = await pref.getString('pass') ?? '';

    if(user == userController.text && pass == passController.text){

      return true;

    }else{

      return false;
    }



  }
}
