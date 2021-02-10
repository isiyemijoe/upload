import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upload/editPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List tbleRows = [];
  bool sort = false;
  Excel selectedExcel;
  String sheetName;
  List selectedRows = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
              onTap: saveExcel,
              child:
                  Padding(padding: EdgeInsets.all(5), child: Icon(Icons.save))),
          selectedRows.isNotEmpty
              ? GestureDetector(
                  onTap: removeFromExcel,
                  child: Padding(
                      padding: EdgeInsets.all(5), child: Icon(Icons.delete)))
              : Container()
        ],
      ),
      body: selectedExcel != null
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  horizontalMargin: 8,
                  sortAscending: sort,
                  sortColumnIndex: 1,
                  dataRowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.08);
                    return null; // Use the default value.
                  }),
                  columnSpacing: 15.0,
                  columns: [
                    DataColumn(numeric: false, label: Text("Title")),
                    DataColumn(
                        numeric: false,
                        label: Text("Name"),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            sort = !sort;
                          });
                          onSortColumn(columnIndex, ascending);
                        }),
                    DataColumn(numeric: false, label: Text("Email")),
                  ],
                  rows: tbleRows
                      .map((e) => DataRow(
                              selected: selectedRows.contains(e),
                              onSelectChanged: (b) {
                                print(b);
                                //     print(selectedRows.contains(e));
                                onSelected(b, e);
                              },
                              cells: [
                                DataCell(Text(e[0].toString())),
                                DataCell(Text(e[1].toString())),
                                DataCell(Text(e[2].toString()))
                              ]))
                      .toList()))
          : Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Where is your excel document?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            color: Colors.blue,
                            onPressed: createNewExel,
                            child: Text(
                              "Create a new one",
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        FlatButton(
                            color: Colors.blue,
                            onPressed: pickFile,
                            child: Text(
                              "Pick from storage",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: selectedExcel != null
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditPage()))
                    .then((value) {
                  print(value);
                  if (value != null) {
                    print(value);
                    insertIntoExcel(value);
                  }
                });
              },
            )
          : null,
    );
  }

  createNewExel() {
    var excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    selectedExcel = excel;
    sheetName = "Sheet1";
    getList();
  }

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);

      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      selectedExcel = excel;
      print(selectedExcel["Sheet1"].sheetName);
      Sheet sheet = selectedExcel["Sheet1"];
      sheetName = sheet.sheetName;

      getList();
    } else {
      // User canceled the picker
    }
    print("The final List of List Length is ${tbleRows.length}");
  }

  void onSortColumn(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      if (ascending) {
        tbleRows.sort((a, b) => a[1].compareTo(b[1]));
      }
      if (!ascending) {
        tbleRows.sort((a, b) => b[1].compareTo(a[1]));
      }
    }
  }

  getList() async {
    tbleRows.clear();
    print(selectedExcel[sheetName].rows.length);
    for (var row in selectedExcel[sheetName].rows) {
      print(row);
      tbleRows.add(row);
    }

    setState(() {});
  }

  insertIntoExcel(List<String> data) {
    Sheet sheetObject = selectedExcel["Sheet1"];

    sheetObject.appendRow(data);
    getList();
  }

  saveExcel() async {
    var res = await Permission.storage.request();
    File file = File(("/storage/emulated/0/Download/excel2.xlsx"));
    if (res.isGranted) {
      if (await file.exists()) {
        print("File exist");
        await file.delete().catchError((e) {
          print(e);
        });
      }
      selectedExcel.encode().then((onValue) {
        file
          ..createSync(recursive: true)
          ..writeAsBytesSync(onValue);
      });
    }
  }

  void updateRow(var rowData) {
    Sheet sheetObject = selectedExcel[sheetName];
    var index = tbleRows.indexOf(rowData);
    String alphabet = "A";
    for (var row in rowData) {
      alphabet = getNextAlphabet(alphabet);
      //var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    }
  }

  void removeFromExcel() {
    if (selectedRows.isNotEmpty) {
      for (var row in selectedRows) {
        //print(tbleRows.indexOf(row));
        selectedExcel[sheetName].removeRow(selectedRows.indexOf(row));
      }
      selectedRows.clear();
      getList();
    }
  }

  void onSelected(bool selected, e) async {
    setState(() {
      if (selected) {
        selectedRows.add(e);
      } else {
        selectedRows.remove(e);
      }
    });
  }

  getNextAlphabet(var c) {
    return String.fromCharCode(c.charCodeAt(0) + 1);
  }
}
