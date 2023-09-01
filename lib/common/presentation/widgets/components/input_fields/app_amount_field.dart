import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../../../utilities/input_formatters/amount_input_formatter.dart';
import 'app_text_field.dart';

class AppAmountField extends AppTextField {
  AppAmountField({
    super.key,
    required AmountFieldController controller,
    String? label,
    String? hint,
    String? Function(double amount)? validator,
    List<TextInputFormatter>? formatters,
    bool isRequired = false,
    ValueChanged<double>? onChanged,
    VoidCallback? onEditComplete,
    String? prefixText,
    Widget? prefix,
    Widget? suffix,
  }) : super(
          controller: controller,
          label: label,
          hint: hint,
          isRequired: isRequired,
          validator:
              validator != null ? (_) => validator(controller.amount) : null,
          formatters: [
            // If formatters is not null, remove AmountThousandthFormatter from it
            // and spread the rest into this input's formatters
            ...(formatters ?? [])
              ..removeWhere(
                (frt) => frt.runtimeType == AmountThousandthFormatter,
              ),
            // AmountThousandthFormatter included wether formatters is null or not
            AmountThousandthFormatter(),
          ],
          prefixText: prefixText,
          prefix: prefix,
          suffix: suffix,
          onChanged:
              onChanged != null ? (_) => onChanged(controller.amount) : null,
          onEditComplete: onEditComplete,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        );
}

class AmountFieldController extends TextEditingController {
  double get amount {
    final clean = text.replaceAll(',', '');
    final val = double.tryParse(clean);
    return val ?? 0;
  }

  set amount(double amount) {
    TextEditingValue text;
    final formatter = AmountThousandthFormatter();
    if (amount.truncateToDouble() == amount) {
      text = formatter.format(amount.truncate());
    } else {
      text = formatter.format(amount);
    }
    value = text;
  }
}
