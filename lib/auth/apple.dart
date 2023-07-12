import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:show_contakt/sample_page.dart';

class AppleAuthButton extends StatelessWidget {
  const AppleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const SamplePage(),
          ),
        );
      },
      padding: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF000000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/apple.svg', width: 25, color: Color(0xFFFFFFFF)),
          const SizedBox(width: 20),
          const Text(
              'Continue with Apple',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Exo',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )
          )
        ],
      ),
    );
  }

}