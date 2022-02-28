import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfscancorafluttergetx/constants/colors.dart';
import 'package:selfscancorafluttergetx/screens/basket_screen/basket_screen_controller.dart';

class CustomAppBar extends StatelessWidget {
  final basketController = Get.put(BasketScreenController());

  final String title;
  final Widget right;

  CustomAppBar({
    required this.title,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 5),
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: kWhite),
            color: kWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      basketController.getListOfProducts();
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: kBlue,
                          size: 16,
                        ),
                        Text(
                          'Inapoi',
                          style: TextStyle(
                            fontSize: 16,
                            color: kBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: kDarkGrey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: right,
                ),
              ],
            ),
          ),
        ),
        Row(
          children: List.generate(
            (MediaQuery.of(context).size.width / 20).toInt(),
            (index) => Expanded(
              child: Image.asset('images/decoration.png'),
            ),
          ),
        )
      ],
    );
  }
}
