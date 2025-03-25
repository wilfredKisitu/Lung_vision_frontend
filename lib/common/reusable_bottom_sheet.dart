import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/providers/get_user_data.dart';
import 'package:lungv_app/providers/update_user_provider.dart';

class UpdateFieldBottomSheet extends ConsumerStatefulWidget {
  final String title;
  final String fieldKey;
  final String hintText;
  final TextInputType inputType;

  const UpdateFieldBottomSheet({
    required this.title,
    required this.fieldKey,
    required this.hintText,
    this.inputType = TextInputType.text,
    super.key,
  });

  @override
  ConsumerState<UpdateFieldBottomSheet> createState() =>
      _UpdateFieldBottomSheetState();
}

class _UpdateFieldBottomSheetState
    extends ConsumerState<UpdateFieldBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _loading = false;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final updateData = {widget.fieldKey: _controller.text.trim()};

    // Store references to avoid async gaps
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final updateFuture = ref.read(updateUserFieldProvider(updateData).future);

    setState(() => _loading = true);

    updateFuture
        .then((_) {
          navigator.pop();
          ref.invalidate(getUserProvider);
          messenger.showSnackBar(
            SnackBar(content: Text('${widget.title} updated')),
          );
        })
        .catchError((e) {
          messenger.showSnackBar(SnackBar(content: Text("Error: $e")));
        })
        .whenComplete(() {
          if (mounted) {
            setState(() => _loading = false);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Update your ${widget.title}",
                style: AppTextStyles.normal14,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: _controller,
                keyboardType: widget.inputType,
                decoration: InputDecoration(labelText: widget.hintText),
                obscureText: widget.fieldKey == "password",
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "This field is required"
                            : null,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    child:
                        _loading
                            ? const CircularProgressIndicator()
                            : Text("Submit", style: AppTextStyles.normal14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
