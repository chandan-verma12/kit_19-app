import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'delete_notes (1).dart';

class Deletes extends StatefulWidget {
  Deletes({Key? key}) : super(key: key);

  @override
  State<Deletes> createState() => _DeletesState();
}

class _DeletesState extends State<Deletes> {
  bool _isLoading = false;

  var noteID;

  Future deleteNote(String noteID) {
    return http.delete(
      Uri.parse('https://services.kit19.com/UserCRM/DeleteNotes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((data) {
      if (data.statusCode == 204) {
        return DeleteNotes;
      }
      return Text('error an occur');
    }).catchError((_) => Text('error not handle'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (_) {
        if (_isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Colors.green),
            itemCount: 2,
            itemBuilder: (_, index) {
              return Dismissible(
                child: Text('hhh'),
                key: ValueKey(deleteNote('noteId')),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => DeleteNotes());

                  if (result) {
                    final deleteResult = DeleteNotes;

                    var message;
                    if (deleteResult != null && deleteResult == true) {
                      message = 'The note was deleted successfully';
                    }

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Done'),
                              content: Text(message),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ));

                    return false;
                  }
                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              );
            });
      },
    ));
  }
}

      
    
    
// class APIResponse<T> {
//   T data;
//   bool error;
//   String errorMessage;

//   APIResponse({this.data, this.errorMessage, this.error=false});
// }