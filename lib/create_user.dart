// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:demo/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'util.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ratingController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  Gender? selectedGender;

  XFile? xFile1;

  String gender="";


  void _addUser() {
    final String fname = fnameController.text;
    final String lname = lnameController.text;
    final String email = emailController.text;
    final String phone = phoneController.text;
    final String address = addressController.text;
    final String rating = ratingController.text;
    final String Gender_1=gender!;
    final XFile xfile = xFile1!;

    if (fname.isNotEmpty &&
        lname.isNotEmpty &&
        email.isNotEmpty &&
        address.isNotEmpty &&
        rating.isNotEmpty &&
        phone.isNotEmpty) {
      setState(() {
        userList.add(User(
            fname: fname,
            lname: lname,
            email: email,
            phone: phone,
            rat: rating,
            address: address,
            xFile: xfile,
            gender: Gender_1));
      });

      fnameController.clear();
      lnameController.clear();
      emailController.clear();
      phoneController.clear();
      addressController.clear();
      Navigator.pushNamed(context, home_page);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(21),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(vertical: 50),
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.black,
                            backgroundImage: xFile1 != null
                                ? FileImage(
                              File(xFile1?.path ?? ""),
                            )
                                : null,
                            child: Text("Add"),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 80,
                            child: IconButton(
                                onPressed: () async {
                                  xFile1 = await picker.pickImage(
                                      source: ImageSource.camera);

                                  setState(() {});
                                },
                                icon: Icon(Icons.camera_alt_rounded)),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 90,
                            child: IconButton(
                                onPressed: () {
                                  picker
                                      .pickImage(source: ImageSource.gallery)
                                      .then((value) {
                                    xFile1 = value;
                                    setState(() {});
                                  });
                                },
                                icon: Icon(Icons.photo)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: "",
                            controller: fnameController,
                            onFieldSubmitted: (value) {

                            },
                            onSaved: (newValue) {

                            },
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Enter Your First Name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Fisrt Name",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: lnameController,
                            onFieldSubmitted: (value) {
                              print("onFieldSubmitted $value");
                            },
                            onSaved: (newValue) {
                              print("On Save $newValue");
                            },
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Enter Your Last Name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Last Name",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate,
                        color: Colors.grey,),
                        SizedBox(width: 15),
                        Expanded(child: TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return "Enter Rating";
                            } else if(int.tryParse(value!) !>6){
                              return "Enter Rating Between 1 to 5";
                            }
                            else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: ratingController,
                          decoration: InputDecoration(
                            hintText: "Enter Ratting Between 1 to 5",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return "Enter Email address";
                                } else if (!value!.contains("@")) {
                                  return "Enter Valid Email address";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.transgender,
                          color: Colors.grey,
                        ),
                        Radio(
                          value: Gender.male,
                          groupValue: selectedGender,
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            selectedGender = value;
                            print(value);
                            gender="Male";
                            print(gender);
                            setState(() {});
                          },
                        ),
                        InkWell(
                          onTap: () {
                            selectedGender = Gender.male;
                            setState(() {});
                          },
                          child: Text("Male",style: TextStyle(color: Colors.grey)),
                        ),
                        Radio(
                          value: Gender.female,
                          groupValue: selectedGender,
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            selectedGender = value;
                            gender="female";
                            print(value);
                            setState(() {});
                          },
                        ),
                        InkWell(
                          onTap: () {
                            selectedGender = Gender.female;
                            setState(() {});
                          },
                          child: Text("Female",style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.phone_android, color: Colors.grey),
                        SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            onSaved: (newValue) {},
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "Enter Phone Number";
                              } else if (int.tryParse(value ?? "") == null) {
                                return "Enter Valid Phone Number";
                              } else if (value?.length!=10) {
                                return "Enter Valid Phone Number";
                              }
                              else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Phone",
                              // prefix: Icon(Icons.phone_android),
                              // prefixIcon: Icon(Icons.phone_android),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: addressController,
                                keyboardType: TextInputType.streetAddress,
                                validator: (value) {
                                  if (value?.isEmpty ?? false) {
                                    return "Enter City";
                                  } else {
                                    return null;
                                  }
                                },
                                // obscureText: true,
                                // obscuringCharacter: "-",
                                decoration: InputDecoration(
                                  helperMaxLines: 5,
                                  hintText: "Enter City",
                                  // prefix: Icon(Icons.phone_android),
                                  // prefixIcon: Icon(Icons.phone_android),
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                            ),
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                FocusScope.of(context).unfocus(); // For keyboard Close
                                formKey.currentState?.save();
                                if(xFile1!=null){
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("User Created Successfully"),
                                    duration: Duration(seconds: 6),
                                    backgroundColor: Colors.red,
                                    action: SnackBarAction(
                                      label: "Success",
                                      onPressed: () {},
                                    ),
                                  ));
                                }
                                else if(xFile1==null)
                                  {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Select Any Profile Picture!!"),
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.red,
                                      action: SnackBarAction(
                                        label: "Warning",
                                        onPressed: () {},
                                      ),
                                    ));
                                  }
                                _addUser();
                              } else {
                                print("Invalid");
                              }
                            },
                            child: Text("Save")),
                        SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                          ),
                            onPressed: () {
                              print("Reset");
                              fnameController.clear();
                              lnameController.clear();
                              emailController.clear();
                              phoneController.text = "";
                              addressController.text = "";
                              formKey.currentState?.reset();
                              xFile1=null;
                              print(selectedGender);
                              FocusScope.of(context)
                                  .unfocus(); // For keyboard Close
                            },
                            child: Text("Reset")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


enum Gender { male, female }
