import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchBar extends HookConsumerWidget {
  const SearchBar({Key? key, required this.provider}) : super(key: key);

  final StateProvider<String> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: ref.read(provider.notifier).state);

    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded),
                onPressed: () {
                  controller.text = '';
                  ref.read(provider.notifier).state = '';
                },
              )
            : null,
      ),
      controller: controller,
      onChanged: (value) => ref.read(provider.notifier).state = value,
    );
  }
}
