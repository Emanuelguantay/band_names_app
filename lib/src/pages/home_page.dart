import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names_app/src/models/band_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: '1', name: 'Metallica', votes: 6),
    BandModel(id: '2', name: 'Queen', votes: 3),
    BandModel(id: '3', name: 'Bon Jovi', votes: 1),
    BandModel(id: '4', name: 'Rata Blanca', votes: 9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Lista de Bandas',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return _bandTile(bands[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 5);
          },
          itemCount: bands.length),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: () {
          _addNewBand();
        },
      ),
    );
  }

  _bandTile(BandModel band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        //TODO: Agregar borrado
        print(direction);
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft, 
          child: Text('Eliminar',
          style: TextStyle(color: Colors.white))),
      ),
          child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  _addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Nueva Banda: '),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  child: Text('Agregar'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () {
                    addBandToList(textController.text);
                  },
                )
              ],
            );
          });
    }
    
    showCupertinoDialog(
      context: context, 
      builder: (_){
        return CupertinoAlertDialog(
          title: Text('Nueva Banda: '),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Agregar'),
              onPressed: () {
                    addBandToList(textController.text);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  void addBandToList(String name) {
    print(name);

    if (name.length > 1) {
      bands.add(new BandModel(id: DateTime.now().toString(), name: name, votes: 0 ));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
