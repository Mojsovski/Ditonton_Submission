import 'package:core/styles/text_styles.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv/search_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv/common/tv_event.dart';
import 'package:tv/presentation/bloc/tv/common/tv_state.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvBloc>().add(OnTvSearch(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc, TvState>(
              builder: (context, state) {
                if (state is TvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return TvCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is TvError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error'),
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
