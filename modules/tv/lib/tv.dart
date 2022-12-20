library core;

//data
//datasource
export 'data/datasources/db/database_helper_tv.dart';
export 'data/datasources/tv/tv_local_data_source.dart';
export 'data/datasources/tv/tv_remote_data_source.dart';
//models
export 'data/models/tv/tv_detail_model.dart';
export 'data/models/tv/tv_episode_model.dart';
export 'data/models/tv/tv_model.dart';
export 'data/models/tv/tv_response.dart';
export 'data/models/tv/tv_season_detail_model.dart';
export 'data/models/tv/tv_season_model.dart';
export 'data/models/tv/tv_table.dart';
//repositories
export 'data/repositories/tv/tv_repository_impl.dart';

//domain
//entities
export 'domain/entities/tv/tv.dart';
export 'domain/entities/tv/tv_detail.dart';
export 'domain/entities/tv/tv_episode.dart';
export 'domain/entities/tv/tv_season.dart';
export 'domain/entities/tv/tv_season_detail.dart';
//repositories
export 'domain/repositories/tv_repository.dart';
//usecases
export 'domain/usecases/tv/get_airing_today_tvs.dart';
export 'domain/usecases/tv/get_on_the_air_tvs.dart';
export 'domain/usecases/tv/get_popular_tvs.dart';
export 'domain/usecases/tv/get_top_rated_tvs.dart';
export 'domain/usecases/tv/get_tv_detail.dart';
export 'domain/usecases/tv/get_tv_recommendations.dart';
export 'domain/usecases/tv/get_watchlist_tvs_status.dart';
export 'domain/usecases/tv/get_watchlist_tvs.dart';
export 'domain/usecases/tv/remove_watchlist_tvs.dart';
export 'domain/usecases/tv/save_watchlist_tvs.dart';
export 'domain/usecases/tv/search_tvs.dart';

//presentation
//bloc
export 'presentation/bloc/tv/search_tv_bloc.dart';
export 'presentation/bloc/tv/airing_today_bloc.dart';
export 'presentation/bloc/tv/on_the_air_bloc.dart';
export 'presentation/bloc/tv/popular_tv_bloc.dart';
export 'presentation/bloc/tv/top_rated_tv_bloc.dart';
export 'presentation/bloc/tv/watchlist_tv_bloc.dart';
export 'presentation/bloc/tv/tv_detail_bloc.dart';
export 'presentation/bloc/tv/tv_recommendations_bloc.dart';
export 'presentation/bloc/tv/common/tv_event.dart';
export 'presentation/bloc/tv/common/tv_state.dart';

//pages
export 'presentation/pages/tv/home_tv_page.dart';
export 'presentation/pages/tv/tv_detail_page.dart';
export 'presentation/pages/tv/popular_tvs_page.dart';
export 'presentation/pages/tv/airing_today_tvs_page.dart';
export 'presentation/pages/tv/search_tvs_page.dart';
export 'presentation/pages/tv/top_rated_tvs_page.dart';
export 'presentation/pages/tv/watchlist_tvs_page.dart';
export 'presentation/pages/tv/on_the_air_tvs_page.dart';

//widget
export 'presentation/widgets/tv_card_list.dart';
