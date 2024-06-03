import 'package:advancedalarm/models/model.dart';
import 'package:flutter/material.dart';
import 'package:advancedalarm/models/model.dart';

class ToDoItem extends StatelessWidget {
  final Model todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;
  
  const ToDoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),color: Color.fromARGB(255, 180, 179, 179).withOpacity(0.4),),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: const Color.fromARGB(255, 85, 81, 81),
        leading: InkWell(
          onTap: () {
            onToDoChanged(todo);
          },
          child: Container(
            height: 32,
            width: 50,
            padding: todo.set ? const EdgeInsets.fromLTRB(12, 0, 0, 0) :const EdgeInsets.fromLTRB(11, 1, 0, 1),
            decoration: BoxDecoration(
              color: todo.set ? Color.fromARGB(255, 68, 117, 224) : Color.fromARGB(255, 135, 46, 252),
              border: Border.all(color: todo.set ? const Color.fromARGB(255, 68, 117, 224) : Color.fromARGB(255, 137, 77, 216)),
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Text(
              todo.set ? 'on' : 'off',
              style: TextStyle(fontSize: todo.set ? 21 : 20,fontWeight: todo.set ?  FontWeight.w600 : FontWeight.w400 ),
            ),
          ),
        ),
        title: Padding(
          padding: todo.set ?  const EdgeInsets.only(left: 55.0): const EdgeInsets.only(left: 57.0),
          child: Text(
            todo.time,
            style: TextStyle(
              fontSize: 36,
              fontWeight: todo.set ? FontWeight.w800 : FontWeight.w400,
              color: todo.set ? Colors.white : Colors.white60,
            ),
          ),
        ),
        trailing: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 40,
          width: 35,
          decoration: BoxDecoration(
            color: todo.set ? Color.fromARGB(255, 68, 117, 224) : Color.fromARGB(255, 135, 46, 252),
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 19,
            onPressed: () {
              onDeleteItem(todo.id,todo.randomNotifications
              
              ,todo.israndom);
            },
            icon: const Icon(Icons.delete),
          ),
          
        ),
      ),
     
    );
  }
}
