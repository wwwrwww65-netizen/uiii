import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class OnboardingDevicePage extends NyStatefulWidget {
  static RouteView path = ("/onboarding-device", (_) => OnboardingDevicePage());
  OnboardingDevicePage({super.key}) : super(child: () => _OnboardingDevicePageState());
}

class _OnboardingDevicePageState extends NyPage<OnboardingDevicePage> {
  String? _selectedModel;

  final List<String> _models = const [
    '<<MODEL_A>>',
    '<<MODEL_B>>',
    '<<MODEL_C>>',
  ];

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select your device".tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Choose your device model to tailor troubleshooting".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedModel,
              decoration: InputDecoration(labelText: "Device model".tr()),
              items: _models
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedModel = val),
            ),
            const Spacer(),
            FilledButton(
              onPressed: _selectedModel == null
                  ? null
                  : () async {
                      await NyStorage.store('FIRST_RUN_DEVICE_MODEL', _selectedModel);
                      if (!mounted) return;
                      routeTo("/");
                    },
              child: Text("Continue".tr()),
            )
          ],
        ),
      ),
    );
  }
}