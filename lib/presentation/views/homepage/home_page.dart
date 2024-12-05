import 'package:flutter/material.dart';
import 'package:jeleapps_tasks/presentation/views/homepage/home_page_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final vm = HomePageVm();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await vm.requestPermission(context);
      if (mounted) {
        vm.getToken(context);
        vm.listenNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('JeleApps'),
        ),
        body: ListenableBuilder(
            listenable: vm,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: vm.fcmToken.isEmpty
                      ? const Text('Welcome to JeleApps!')
                      : SelectableText(vm.fcmToken),
                ),
              );
            }));
  }
}
