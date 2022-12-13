import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../../controller/b2b_controller.dart';
import '../../models/user_model.dart';
import '../../../main.dart';
import '../../models/association_model.dart';

import 'package:velocity_x/velocity_x.dart';

import '../screens/association_details_page.dart';
import '../services/associations_api.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({
    Key? key,
    required this.association,
  }) : super(key: key);
  final Association association;

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  String userName = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  //========Hive_Stuff====================================
  late Box<UserModel> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<UserModel>(userBoxName);
  }

  @override
  Widget build(BuildContext context) {
    B2BController controller = Get.put(B2BController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff000000),
        title: Text(
          '${widget.association.name} User',
          style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color(0xffdadada),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          widget.association.imageUrl,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Enter Some Value';
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(color: Color(0xff000000)),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'User Name',
                      hintText: 'Enter username',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Economica",
                        letterSpacing: 1.0,
                        color: Color(0xff000000),
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Economica",
                        letterSpacing: 2.0,
                        color: Color(0xff000000),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        userName = val;
                      });
                    },
                    onFieldSubmitted: (val) {
                      setState(() {
                        userName = val;
                      });
                    },
                    onSaved: (val) {
                      setState(() {
                        userName = val!;
                      });
                    },
                  ),
                  const HeightBox(10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    validator: (pass) {
                      if (pass!.length < 5) {
                        return 'Password must be of 5 character';
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(color: Color(0xff000000)),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Password',
                      hintText: 'Enter password',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Economica",
                        letterSpacing: 1.0,
                        color: Color(0xff000000),
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Economica",
                        letterSpacing: 2.0,
                        color: Color(0xff000000),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    onFieldSubmitted: (val) {
                      setState(() {
                        userName = val;
                      });
                    },
                    onSaved: (val) {
                      setState(() {
                        userName = val!;
                      });
                    },
                  ),
                  const HeightBox(20),
                  Obx(() {
                    if (controller.isLoading.isTrue) {
                      return const CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isLogin = await controller.getUserLogin(
                              aUserName: userName,
                              aUserPassword: password,
                              aName: widget.association.name,
                              aId: widget.association.id,
                            );
                            if (isLogin) {
                              UserModel user = UserModel(
                                username: userName,
                                password: password,
                                aName: widget.association.name,
                                aId: widget.association.id,
                                aType: widget.association.atype,
                              );
                              userBox.put(widget.association.id, user);
                              await FirebaseMessaging.instance
                                  .subscribeToTopic(widget.association.name);
                              Get.off(
                                () => AssociationDetailPage(
                                  association: widget.association,
                                  userName: userName,
                                  password: password,
                                ),
                              );
                            } else {
                              Get.defaultDialog(
                                title: 'Error',
                                titleStyle:
                                    const TextStyle(color: Colors.redAccent),
                                middleText: 'Authentication Failed',
                              );
                            }
                          } else {
                            Get.defaultDialog(
                              title: 'Error',
                              titleStyle:
                                  const TextStyle(color: Colors.redAccent),
                              middleText: 'Please enter correct values',
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff000000),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 40),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Economica",
                            letterSpacing: 1.2,
                          ),
                        ),
                      );
                    }
                  }),
                  const HeightBox(15),
                  ElevatedButton(
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        await Apis.getPassword(
                          org: widget.association.name,
                          userId: _emailController.text,
                          assid: widget.association.id,
                        ).then(
                          (value) {
                            setState(() {
                              isLoading = false;
                            });
                            Get.defaultDialog(
                              title: 'Message',
                              titleStyle:
                                  const TextStyle(color: Colors.redAccent),
                              middleText: '$value',
                            );
                          },
                        );
                      } else {
                        Get.defaultDialog(
                          title: 'Error',
                          titleStyle: const TextStyle(color: Colors.redAccent),
                          middleText: 'Username can\'t be empty',
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffff0505),
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    child: (isLoading)
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Get Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Economica",
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                  const HeightBox(15),
                  Text(
                    'Please ask your association, if your email id is not registered with ${widget.association.name}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
