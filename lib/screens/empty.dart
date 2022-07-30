import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ClipRRect(

          borderRadius: BorderRadius.circular(10),
          child: CoolDropdown(
        
            dropdownList: const [
          {'label': 'apple', 'value': 'apple'}, // label is required and unique
          {'label': 'banana', 'value': 'banana'},
          {'label': 'grape', 'value': 'grape'},
          {'label': 'pineapple', 'value': 'pineapple'},
          {'label': 'grape fruit', 'value': 'grape fruit'},
          {'label': 'kiwi', 'value': 'kiwi'},
            ], 
            onChange: (){
        
            }),
        )
      )
    );
  }
}
