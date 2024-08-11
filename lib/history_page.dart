import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/main_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
    context.read<MainProvider>().getResultDB();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('History Page'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  value.mainState.resultDB != null
                    ? Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.mainState.resultDB!.length,
                      itemBuilder: (context, index) {
                        String result = value.mainState.resultDB![index].result;
                        String correctAnswers = value.mainState.resultDB![index].correctAnswers;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                result,
                              ),
                            ),
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                correctAnswers,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                    : const Text('history is empty'),
                ],
              ),
            ),
          );
        },
    );
  }
}
