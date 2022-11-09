import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A custom search bar that is used for live searching.
class SearchBar extends HookConsumerWidget {
  ///
  const SearchBar({super.key, required this.provider});

  /// The [StateProvider] that will be used for this widget.
  final StateProvider<String> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: ref.read(provider.notifier).state,
    );

    void clear() {
      controller.text = '';
      ref.read(provider.notifier).state = '';
    }

    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded),
                onPressed: clear,
              )
            : null,
      ),
      controller: controller,
      onChanged: (value) => ref.read(provider.notifier).state = value,
    );
  }
}
