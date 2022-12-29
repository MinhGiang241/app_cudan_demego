import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_screen.dart';
import 'prv/construction_reg_prv.dart';

class ConstructionRegScreen extends StatefulWidget {
  const ConstructionRegScreen({Key? key}) : super(key: key);
  static const routeName = '/construction/create';

  @override
  _ConstructionRegScreenState createState() => _ConstructionRegScreenState();
}

class _ConstructionRegScreenState extends State<ConstructionRegScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ConstructionRegPrv(),
        builder: (context, state) {
          return PrimaryScreen(
            isPadding: false,
            appBar: PrimaryAppbar(
              title: S.of(context).reg_const,
            ),
            body: SafeArea(
              child: Container(
                  // decoration: BoxDecoration(color: Colors.red),
                  padding: const EdgeInsets.all(0),
                  child: Stepper(
                    type: StepperType.horizontal,
                    elevation: 0,
                    currentStep: currentStep,
                    onStepCancel: () => currentStep == 0
                        ? null
                        : setState(() {
                            currentStep -= 1;
                          }),
                    onStepContinue: () {
                      bool isLastStep = (currentStep == getSteps().length - 1);
                      if (isLastStep) {
                        //Do something with this information
                      } else {
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    },
                    onStepTapped: (step) => setState(() {
                      currentStep = step;
                    }),
                    steps: getSteps(),
                  )),
            ),
          );
        });
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text(S.of(context).step1),
        content: Column(
          children: [
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text(S.of(context).step2),
        content: Column(
          children: [
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text(S.of(context).step3),
        content: Column(
          children: [
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
            PrimaryTextField(
              label: "sasdasdas",
            ),
          ],
        ),
      ),
    ];
  }
}
