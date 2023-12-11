import 'package:flutter/Material.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/app_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DemoNoti extends StatefulWidget {
  const DemoNoti({super.key});

  @override
  State<DemoNoti> createState() => _DemoNotiState();
}

class _DemoNotiState extends State<DemoNoti> {
  late IO.Socket socket;
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    socket =
        IO.io(uri, IO.OptionBuilder().setTransports(['websocket']).build());
    socket.on('notification', (data) {
      print('Got the new notification here: $data');
      setState(() {
        notifications.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeDark,
      body: SafeArea(
        child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notifications[index]['title']),
                subtitle: Text(notifications[index]['body']),
              );
            }),
      ),
    );
  }
}
