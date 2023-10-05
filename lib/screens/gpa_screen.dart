import 'package:calculatorapp/provider/calculator_model.dart';
import 'package:calculatorapp/util/colors.dart';
import 'package:calculatorapp/util/decoration_widgets.dart';
import 'package:calculatorapp/widgets/general_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../widgets/dismissible_component.dart';
import '../widgets/explainer_card.dart';
import '../widgets/input_detail.dart';

class GpaScreen extends StatelessWidget {
  const GpaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var calculator = context.watch<CalculatorModel>();
    double pixRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExplainerCard(pixRatio: pixRatio),
              SizedBox(
                height: 46 / pixRatio,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.add_circle,
                        size: 18.h,
                        color: kSecondaryBlackColor,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          calculator.addItems(
                            const InputDetails(),
                          );
                        },
                        child: const Text(
                          'Add Course',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      calculator.removeAll();
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: kBlueColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 22.h,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: calculator.userInputs.length,
                    itemBuilder: (context, index) {
                      return DismissibleComponent(
                        calculator: calculator,
                        index: index,
                      );
                    }),
              ),
              GeneralButton(
                text: 'Calculate',
                onPressed: () {
                  calculator.gpaResult();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                              height: 269.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 55.w),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      kGreenWoman,
                                      width: 191.w,
                                      height: 191.h,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('Your GPA is 4.0',
                                        style: gpaResultTextStyle),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
