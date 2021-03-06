
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveisblue/global.dart';
class MessageSet extends StatefulWidget {
  @override
  _MessageSetState createState() => _MessageSetState();
}

class _MessageSetState extends State<MessageSet> {
  String _pickingType = "text";
  String id = Global.id;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          middle: Text("Set Message"),
          trailing: Material(
              color: Colors.white,
              child: InkWell(
                child: Icon(Icons.check),
                onTap: () {
                      Firestore.instance.collection('users').document(id).setData({"message":controller.text,"type":_pickingType},merge: true);
                      Navigator.pop(context);
                },
              )),
        ),
        child: CustomScrollView(
          slivers: [
             SliverList(
                delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              Material(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    controller: controller,
                maxLines: 3,
              )),
              SizedBox(
                height: 20,
              ),
              Material(
                child: DropdownButton(
                    hint: new Text('Message Type'),
                    value: _pickingType,
                    items: <DropdownMenuItem>[
                      new DropdownMenuItem(
                        child: new Text('Text'),
                        value: "text",
                      ),
                      new DropdownMenuItem(
                        child: new Text('Audio'),
                        value: "audio",
                      ),
                      new DropdownMenuItem(
                        child: new Text('Image'),
                        value: "image",
                      ),
                      new DropdownMenuItem(
                        child: new Text('Link'),
                        value: "link",
                      ),
                    ],
                    onChanged: (value) => setState(() {
                          _pickingType = value;
                        })),
              ),
            ]))
          ],
        ));
  }
}
