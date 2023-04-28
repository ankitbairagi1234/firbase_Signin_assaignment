// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Container(child: Center(child: Text("Wellcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),)),)
//     );
//   }
// }

import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:image_picker/image_picker.dart';
import 'color.dart';
import 'package:firebase_storage/firebase_storage.dart'as firabase_storage;

import 'main.dart';




class RegistrationScreen extends StatefulWidget {



  RegistrationScreen({Key? key, }) : super(key: key);


  @override
  State<RegistrationScreen> createState() => _DoctorResignationState();
}

class _DoctorResignationState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
 final TextEditingController nameController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController stateController =  TextEditingController();

  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;



  clearText(){
    nameController.clear();
    detailController.clear();
    stateController.clear();
  }

  var items = [
    'Andhra Pradesh(Amaravati)',
    'Assam(Dispur)',
    'Bihar(Patna)',
    'Chhattisgarh(Raipur)',
    'Uttar Pradesh',
     'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',

  ];

  File? imageFile;
  File? newImageFile;
  String? SelectedGender;
  String? dropdownValue;
  int _value = 1;

  bool isLoading = false;
  String  gender =  "Male";

  int selectedGender = 0;



  final ImagePicker _picker = ImagePicker();

  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _getFromCamera();
                },
                //return false when click on "NO"
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _getFromGallery();

                },
                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }


  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }





  void initState() {
    // TODO: implement initState
    super.initState();


  }

  _uploadFile() async {
   try{
     firabase_storage.UploadTask uploadTask;
     firabase_storage.Reference ref = FirebaseStorage.instance
         .ref()
         .child('product')
         .child('/'+ imageFile!.path);

      uploadTask = ref.putFile(imageFile!);
     await uploadTask.whenComplete(() =>null);
     String imageurl = await ref.getDownloadURL();

     print('upload url'+ imageurl);
   } catch(e){

   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Home",style: TextStyle(color: Colors.white),),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showExitPopup();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8), // Border width
                      decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(48), // Image radius
                          child:imageFile == null || imageFile == ""
                              ? Center(
                              child: Icon(
                                Icons.drive_folder_upload_outlined,
                                color: Colors.grey,
                                size: 60,
                              ))
                              : Image.file(
                            imageFile!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child:Row(
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "name is required";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Select Gender",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            // fillColor: MaterialStateColor.resolveWith(
                            //         (states) =>  secondary),
                            activeColor: Colors.blue,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                gender = "Male";
                                //isMobile = false;
                              });
                            },
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Male",
                            style: TextStyle(
                                fontSize: 15),
                          ),
                          SizedBox(height: 5,),
                          Radio(
                              value: 2,
                              // MaterialStateColor.resolveWith(
                              //         (states) => secondary),
                              activeColor:  Colors.blue,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                  gender = "Female";
                                  // isMobile = true;
                                });
                              }),
                          // SizedBox(width: 10.0,),
                          Text(
                            "Female",
                            style: TextStyle(
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Select State",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Theme.of(context).primaryColor,)
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child:
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(

                                value: dropdownValue,
                                hint:Text("Select State"),
                                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.blue,),
                                elevation: 16,
                                style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                underline: Container(
                                  // height: 2,
                                  color: Colors.black54,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: items
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )

                        ),
                      ),
                      SizedBox(height: 15,),


                    ],
                  ) ,


                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 20,),


                  Center(
                    child: InkWell(
                      onTap: ()
                      {
                        if (_formKey.currentState!.validate()) {
                          _uploadFile();
                          Map<String, dynamic> data = {"name" : nameController.text, "gender":gender,"state" :dropdownValue };
                          firebaseFirestore
                              .collection("userprofile")
                              .add({
                            "name" : nameController.text,
                            "gender" : gender,
                            "state" : dropdownValue
                          }).whenComplete(() => print("Add Success"))
                              .catchError((e)=>print(e));
                          // addData(nameController.text,detailController.text,stateController.text);

                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          const snackBar = SnackBar(
                            content: Text('All Fields are required!'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      },
                      child:
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                            // color: secondary,
                            borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                          ),
                    ),

                  ),
                ],
              ),
            ),
          ),
        ));
  }

}

