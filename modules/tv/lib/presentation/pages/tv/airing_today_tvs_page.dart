import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv/airing_today_bloc.dart';
import 'package:tv/presentation/bloc/tv/common/tv_state.dart';
import 'package:tv/presentation/bloc/tv/common/tv_event.dart';

class AiringTodayTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tv';

  const AiringTodayTvsPage({Key? key}) : super(key: key);

  @override
  _AiringTodayTvsPageState createState() => _AiringTodayTvsPageState();
}

class _AiringTodayTvsPageState extends State<AiringTodayTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<AiringTodayTvsBloc>().add(OnAiringTodayTv()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayTvsBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is TvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Expanded(
                child: Container(),
              );
            }
          },
        ),
      ),
    );
  }
}
