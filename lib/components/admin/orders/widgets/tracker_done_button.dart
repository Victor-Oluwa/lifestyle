import 'package:flutter/Material.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TrackerResetButton extends StatelessWidget {
  const TrackerResetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      color: Colors.black,
      alignment: Alignment.center,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MediumText(
            text: 'Reset Order Status ',
            color: Colors.white,
          ),
          Icon(Icons.restore)
        ],
      ),
    );
  }
}
