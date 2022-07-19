import 'package:flutter/material.dart';

class MergeDeatailCard extends StatefulWidget {
  MergeDeatailCard({
    Key? key,
    required this.name2,
    required this.companyName2,
    required this.mob2,
    required this.email2,
    required this.country2,
    required this.state2,
    required this.resiAddress2,
    required this.offAddress2,
    required this.yesNo2,
    required this.lead2,
    required this.date2,
  }) : super(key: key);
  String name2,
      companyName2,
      mob2,
      email2,
      country2,
      state2,
      resiAddress2,
      offAddress2,
      yesNo2,
      lead2,
      date2;

  @override
  State<MergeDeatailCard> createState() => _MergeDeatailCardState();
}

class _MergeDeatailCardState extends State<MergeDeatailCard> {
  Iterable<int> iterable = [1, 2, 3];
  int selectedRadio = 0;
  Color _colorContainer = Colors.blue;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  final textController = TextEditingController();
  MyFormClass() {
    // Set the text property to a value to be displayed
    textController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 19, 158, 24),
            // border: Border.all(width: 3),
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          height: 210,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Ink(
                  child: Container(
                    height: 30,
                    color: const Color.fromARGB(255, 19, 158, 24),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8, top: 6),
                      child: Text(
                        'Serial',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 160,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('Lead No.'),
                            Radio(
                                activeColor:
                                    const Color.fromARGB(255, 11, 113, 14),
                                value: 1,
                                groupValue: selectedRadio,
                                onChanged: (val) {
                                  setSelectedRadio(val as int);
                                }),
                            const Text('Beta')
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Lead No.'),
                            Radio(
                                activeColor: Color.fromARGB(255, 11, 113, 14),
                                value: 2,
                                groupValue: selectedRadio,
                                onChanged: (val) {
                                  MyFormClass();
                                  setSelectedRadio(val as int);
                                }),
                            Text('Data')
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Final'),
                            const SizedBox(
                              width: 30,
                            ),
                            Flexible(
                              child: TextField(
                                controller: textController,
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey))),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
