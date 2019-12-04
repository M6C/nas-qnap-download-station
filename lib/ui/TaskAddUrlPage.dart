import 'dart:async';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:nas_qnap_download_station/ui/GrabSiteDrawer.dart';
import 'package:nas_qnap_download_station/ui/common/FieldDropDownWidget.dart';
import 'package:nas_qnap_download_station/ui/common/FieldWidget.dart';
import 'package:nas_qnap_download_station/ui/common/TextAreaWidget.dart';
import 'package:nas_qnap_download_station/ui/data/data_url.dart';
import 'package:nas_qnap_download_station/ui/tool/Loader.dart';

class TaskAddUrlPage extends StatefulWidget {
  TaskAddUrlPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TaskAddUrlPageState createState() => _TaskAddUrlPageState();
}

class _TaskAddUrlPageState extends State<TaskAddUrlPage> {

  static final RegExp expProtocol = new RegExp("^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)");
  static List<Response> urlResponses = new List();
  static String url = DATA_URL;
  static List<String> serverItems = ["http://91.165.213.137:60601", "http://192.168.0.17:8080"];
  static List<String> dirMoveItems = ["Download", "USBDisk1"];
  static String server = serverItems[0];
  static String dirMove = dirMoveItems[0];
  static String sid = "";
  static String urlNASUser = "admin";
  static String urlNASPass = "UjMyMTREMzIxNE5BUw==";
  static String urlUrlUser = "david.roca@free.fr";
  static String urlUrlPass = "yCnrv7pDy67mSdyu";
  static bool _log = false;
  static bool _detail = false;
  var _ctrlServer = new TextEditingController(text:server);
  var _ctrlDirMove = new TextEditingController(text:dirMove);
  var _ctrlSid = new TextEditingController(text:sid);
  var _ctrlUrl = new TextEditingController(text:url);
  var _ctrlNASUser = new TextEditingController(text:urlNASUser);
  var _ctrlNASPass = new TextEditingController(text:urlNASPass);
  var _ctrlUrlUser = new TextEditingController(text:urlUrlUser);
  var _ctrlUrlPass = new TextEditingController(text:urlUrlPass);

  static Loader loaderAddUrl = new Loader();
  var fabIcon = Icons.playlist_add;

  @override
  void initState() {
    _ctrlServer.addListener(_ctrlServerListener);
    _ctrlDirMove.addListener(_ctrlDirMovListener);
    _ctrlSid.addListener(_ctrlSidListener);
    _ctrlUrl.addListener(_ctrlUrlListener);
    _ctrlNASUser.addListener(_ctrlNASUserListener);
    _ctrlNASPass.addListener(_ctrlNASPassListener);
    _ctrlUrlUser.addListener(_ctrlUrlUserListener);
    _ctrlUrlPass.addListener(_ctrlUrlPassListener);
  }

  @override
  void dispose() {
    _ctrlServer.dispose();
    _ctrlDirMove.dispose();
    _ctrlSid.dispose();
    _ctrlUrl.dispose();
    _ctrlNASUser.dispose();
    _ctrlNASPass.dispose();
    _ctrlUrlUser.dispose();
    _ctrlUrlPass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} ${urlResponses.length}"),
      ),
      drawer: GrabSiteDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded( // wrap your Column in Expanded
                    child: new Text(_getUrlDownloadStationTaskAddUrl("", obscurePass: true)),
                  ),
                  FlatButton(
                    child: _detail ? const Icon(Icons.arrow_drop_up) : const Icon(Icons.arrow_drop_down),
                    onPressed: (){ setState(() {_detail=!_detail;}); },
                    splashColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
            !_detail ? Container() : Card(color: Colors.white70,
              child:
            Column(children: <Widget>[
                new FieldDropDownWidget(server, "Server Url", ctrl: _ctrlServer, items: serverItems, onSubmitted : (text){}),
                new FieldDropDownWidget(dirMove, "Directory to Move", ctrl: _ctrlDirMove, items: dirMoveItems, onSubmitted : (text){}),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding( padding: const EdgeInsets.only(top: 16.0), child: new Text("NAS Authentication"),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded( // wrap your Column in Expanded
                          child: new FieldWidget(urlNASUser, "User", ctrl: _ctrlNASUser, onSubmitted : (text){}),
                        ),
                        Expanded( // wrap your Column in Expanded
                          child: new FieldWidget(urlNASPass, "Password", obscureText: true, ctrl: _ctrlNASPass, onSubmitted : (text){}),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding( padding: const EdgeInsets.only(top: 16.0), child: new Text("Url Authentication"),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded( // wrap your Column in Expanded
                          child: new FieldWidget(urlUrlUser, "User", ctrl: _ctrlUrlUser, onSubmitted : (text){}),
                        ),
                        Expanded( // wrap your Column in Expanded
                          child: new FieldWidget(urlUrlPass, "Password", obscureText: true, ctrl: _ctrlUrlPass, onSubmitted : (text){}),
                        ),
                      ],
                    ),
                  ],
                ),
              ],),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded( flex: sid.isEmpty ? 1 : 0,
                  child:
                    FlatButton(
                    child: Text("Call New SID"),
                    textColor: sid.isEmpty ? Colors.red : Theme.of(context).accentColor,
                    onPressed: _updateSid,
                  ),
                ),
                sid.isEmpty ? Container() : Expanded( // wrap your Column in Expanded
                  child: new FieldWidget(sid, "SID", onSubmitted : (text){}),
                ),
              ],
            ),
            Expanded(child:
            Stack(alignment: AlignmentDirectional.topEnd,children: <Widget>[
              TextAreaWidget(url, _ctrlUrl,),
              Text(url.split("\n").length.toString()),
            ],),
            ),
            urlResponses.length <= 0 ? Container() : new Expanded(
              child: ListView.builder(itemCount: urlResponses.length, itemBuilder: _buildItemCard),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FloatingActionButton(
//                mini: true,
                onPressed: _addUrl,
                tooltip: 'Add Url',
                child: Icon(fabIcon),
              )
          ),
        ]
      ),
    );
  }

  void _updateSid() {
    var url = _getUrlDownloadStationMiscLogin();
    print("Call New SID - url:$url");
    new Dio().get(url).then((response) {
      print("Call New SID - response:$response");
      print("Call New SID - response.statusCode:${response.statusCode} response.statusMessage:${response.statusMessage}");
      print("Call New SID - response.data:${response.data}");
      var msg = response.statusMessage;
      if (response.statusCode == 200 && response.statusMessage.toUpperCase() == "OK") {
        Map<String, dynamic> json = convert.jsonDecode(response.data.toString());
        msg = json['sid'];
      }
      setState(() {
        sid = msg;
      });
    });
  }

  Future _addUrl() async {
    if (sid == null || sid.isEmpty) {
        showDialog(context: context, builder: (context) =>
        new Dialog( child:
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("Sid can't be empty.\nClick on 'Call New SID'."),
            ),
          ),
        );
        return;
    }
    try {
      loaderAddUrl.onLoading(context, titleWidget: _loadingTitle(fabIcon, _loadingText()));
      _clean();

      List<String> list = url.split("\n").where((u){return u.isNotEmpty;}).toList();
      for(String u in list) {
        if (loaderAddUrl.isLoading()) {
          String url = _getUrlDownloadStationTaskAddUrl(u);
          print("_addUrl - url:$url");
          var response = await new Dio().get(url);
          print("_addUrl - response:$response");
          print("_addUrl - response.statusCode:${response.statusCode} response.statusMessage:${response.statusMessage}");
          print("_addUrl - response.data:${response.data}");
          setState(() {
            urlResponses.add(response);
          });
        } else {
          break;
        }
      }
    } finally {
      loaderAddUrl.unloading(context);
    }
  }

  Row _loadingTitle(icon, text) => Row(children: <Widget>[Padding(padding:const EdgeInsets.only(right: 5.0), child:Icon(icon)), new Text(text)]);
  String _loadingText() => "Adding Url... ${urlResponses.length}";

  Widget _buildItemCard(dynamic context, int index) {
    Response resp = urlResponses[index];
    return new ListTile(
      leading: new Text(resp.statusCode.toString()),
      title: new Text(resp.statusMessage),
      subtitle: new Text(resp.data),
//      onTap: () => showDialog(context: context, builder: (context) => new Dialog(child: image, elevation: 0.0,)),
    );
  }

  void _clean() {
    setState(() {
      urlResponses.clear();
    });
  }

  void _ctrlDirMovListener() => setState(() { dirMove = _ctrlDirMove.text; });
  void _ctrlSidListener() =>  setState(() { sid = _ctrlSid.text; });
  void _ctrlServerListener() => setState(() { server = _ctrlServer.text; });
  void _ctrlNASUserListener() => setState(() { urlNASUser = _ctrlNASUser.text; });
  void _ctrlNASPassListener() => setState(() { urlNASPass = _ctrlNASPass.text; });
  void _ctrlUrlUserListener() => setState(() { urlUrlUser = _ctrlUrlUser.text; });
  void _ctrlUrlPassListener() => setState(() { urlUrlPass = _ctrlUrlPass.text; });
  void _ctrlUrlListener() => setState(() { url = _ctrlUrl.text; });

  var htmlEscape = new convert.HtmlEscape();
  String _getUrlDownloadStationTaskAddUrl(String url, {bool obscurePass = false}) => "$server/downloadstation/V4/Task/AddUrl?sid=$sid&temp=Download&move=$dirMove&user=$urlUrlUser&pass=${obscurePass ? "*******" : convert.base64.encode(convert.utf8.encode(urlUrlPass))}&url=${url}";
  String _getUrlDownloadStationMiscLogin() => "$server/downloadstation/V4/Misc/Login?user=$urlNASUser&pass=$urlNASPass";

  void _logInfo(String text) {
    if (_log) {
      setState(() {
        url += "$text\n";
      });
    }
    print(text);
  }
}
