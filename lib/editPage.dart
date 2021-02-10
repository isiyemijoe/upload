import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _titleController;
  TextEditingController _nameController;
  TextEditingController _emailController;
  String error = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Center(
                            child: Icon(
                          Icons.keyboard_backspace,
                          color: Colors.black,
                          size: 23,
                        )),
                      )),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: new Text(
                      "New Customer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 350),
              width: double.infinity,
              height: error.isEmpty ? 0 : 40,
              color: Colors.red,
              child: Center(
                child: Text(
                  error,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Title",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.sentences,
                            autofocus: false,
                            onSubmitted: (_) {
                              //reload();
                            },
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                isDense: true),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            controller: _titleController,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (s) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.sentences,
                            autofocus: false,
                            onSubmitted: (_) {
                              //reload();
                            },
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                isDense: true),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            controller: _nameController,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (s) {},
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.sentences,
                            autofocus: false,
                            onSubmitted: (_) {
                              //reload();
                            },
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                                isDense: true),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            controller: _emailController,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (s) {},
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: FlatButton(
                      color: Colors.purpleAccent,
                      onPressed: () {
                        saveCustomer();
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      )),
    );
  }

  saveCustomer() {
    if (_titleController.text.isEmpty) {
      showError("Title cannot be empty");
      return;
    }
    if (_nameController.text.isEmpty) {
      showError("name cannot be empty");
      return;
    }
    if (_emailController.text.isEmpty) {
      showError("Email cannot be empty");
      return;
    }

    List<String> result = [
      _titleController.text,
      _nameController.text,
      _emailController.text
    ];
    print(result);
    Navigator.pop(context, result);
  }

  showError(String text) {
    setState(() {
      error = text;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        error = "";
      });
    });
  }
}
