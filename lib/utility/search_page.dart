import 'package:flutter/material.dart';



typedef SearchFilter<T> = List<String?> Function(T t);
typedef ResultBuilder<T> = Widget Function(T t);

class SearchPage<T> extends SearchDelegate<T?> {
  final bool showItemsOnEmpty;
  final Widget suggestion;
  final Widget failure;
  final ResultBuilder<T> builder;
  final SearchFilter<T> filter;
  final String? searchLabel;
  final List<T> items;
  final ThemeData? barTheme;
  final bool itemStartsWith;
  final bool itemEndsWith;
  final void Function(String)? onQueryUpdate;
  final TextStyle? searchStyle;

  SearchPage({
    this.suggestion = const SizedBox(),
    this.failure = const SizedBox(),
    required this.builder,
    required this.filter,
    required this.items,
    this.showItemsOnEmpty = false,
    this.searchLabel,
    this.barTheme,
    this.itemStartsWith = false,
    this.itemEndsWith = false,
    this.onQueryUpdate,
    this.searchStyle,
  }) : super(
          searchFieldLabel: searchLabel,
          searchFieldStyle: searchStyle,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return barTheme ??
        Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                headline6: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline6!.color,
                  fontSize: 20,
                ),
              ),
          appBarTheme: const AppBarTheme(
            // backgroundColor: AppTheme.kPrimaryColor,
            elevation: 0,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: Theme.of(context).primaryTextTheme.caption!.color,
              fontSize: 20,
            ),
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      AnimatedOpacity(
        opacity: query.isNotEmpty ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic,
        child: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (onQueryUpdate != null) onQueryUpdate!(query);
    final String cleanQuery = query.toLowerCase().trim();
    final List<T> result = items
        .where(
          (item) =>
              filter(item).map((value) => value?.toLowerCase().trim()).any(
            (value) {
              if (itemStartsWith == true && itemEndsWith == true) {
                return value == cleanQuery;
              } else if (itemStartsWith == true) {
                return value?.startsWith(cleanQuery) == true;
              } else if (itemEndsWith == true) {
                return value?.endsWith(cleanQuery) == true;
              } else {
                return value?.contains(cleanQuery) == true;
              }
            },
          ),
        )
        .toList();

    return Theme(
      data: Theme.of(context),
      child: cleanQuery.isEmpty && !showItemsOnEmpty
          ? suggestion
          : result.isEmpty
              ? failure
              : ListView(
                  children: result.map(builder).toList(),
                ),
    );
  }
}
