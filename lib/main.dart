import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white
      ),
      home: ListDisplay(),
    );
  }
}

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<ListDisplay> {
  List<Note> litems = [];
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController descController = new TextEditingController();

  void submitList() {
    var title = titleController.text;
    var desc = descController.text;

    if (!title.isEmpty && !desc.isEmpty) {
      print("setting list");
      setState(() {
        litems.add(Note(desc: desc, title: title));
      });
    }
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(child: new Text("Notes", textAlign: TextAlign.center)),
      ),
      // ListView.builder() shall be used here.
      body: new Container(
      
        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: new Column(
          children: <Widget>[
            new Card(
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text("Add Note",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String value) {
                        return value.isEmpty ? 'Enter title' : null;
                      },
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: descController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String value) {
                        return value.isEmpty ? 'Enter desc' : null;
                      },
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: submitList,
                          child: new Text("Add"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            new Container(
              margin: EdgeInsets.all(10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    "Note List",
                    style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 18)
                  )
                ],
              ),
            ),
            new Expanded(
                child: new Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: new ListView.builder(
                  itemCount: litems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new CustomListItem(
                        item: litems[index],
                        index: index,
                        callback: (val) =>
                            setState(() => litems.removeAt(val)));
                  }),
            ))
          ],
        ),
      ),
    );
  }
}

typedef void StringCallback(int val);

class CustomListItem extends StatelessWidget {
  Note item;
  StringCallback callback;
  int index;
  CustomListItem({this.item, this.index, this.callback});

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Row(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(16),
            child: new Text((index + 1).toString()),
          ),
          new Expanded(
            child: new Container(
              padding: new EdgeInsets.only(left: 8.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text(
                   item.title,
                    style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  new Text(
                    item.desc,
                    style: new TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.all(16),
            child: new FlatButton(
              onPressed: () {
                callback(index);
              },
              child: new Text("Delete"),
            ),
          ),
        ],
      ),
    );
  }
}

class Note {
  String title;
  String desc;
  Note({this.title, this.desc});
}
