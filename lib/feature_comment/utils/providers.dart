import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_comment/data/datasources/remote/comment_remote_data_source.dart';
import 'package:samachar_hub/feature_comment/data/repositories/comment_repository.dart';
import 'package:samachar_hub/feature_comment/data/services/comment_remote_service.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_post/comment_post_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_update/comment_update_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/delete/delete_cubit.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_stats/presentation/blocs/thread_stats_cubit.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_type.dart';

class CommentProvider {
  CommentProvider._();
  static setup() {
    GetIt.I.registerLazySingleton<CommentRemoteService>(
        () => CommentRemoteService(GetIt.I.get<HttpManager>()));
    GetIt.I.registerLazySingleton<CommentRemoteDataSource>(
        () => CommentRemoteDataSource(GetIt.I.get<CommentRemoteService>()));
    GetIt.I.registerLazySingleton<CommentRepository>(() => CommentRepository(
          GetIt.I.get<CommentRemoteDataSource>(),
          GetIt.I.get<AnalyticsService>(),
          GetIt.I.get<AuthRepository>(),
        ));
    GetIt.I.registerLazySingleton<DeleteCommentUseCase>(
        () => DeleteCommentUseCase(GetIt.I.get<CommentRepository>()));
    GetIt.I.registerLazySingleton<GetCommentsUseCase>(
        () => GetCommentsUseCase(GetIt.I.get<CommentRepository>()));
    GetIt.I.registerLazySingleton<LikeCommentUseCase>(
        () => LikeCommentUseCase(GetIt.I.get<CommentRepository>()));
    GetIt.I.registerLazySingleton<UnlikeCommentUseCase>(
        () => UnlikeCommentUseCase(GetIt.I.get<CommentRepository>()));
    GetIt.I.registerLazySingleton<UpdateCommentUseCase>(
        () => UpdateCommentUseCase(GetIt.I.get<CommentRepository>()));
    GetIt.I.registerLazySingleton<PostCommentUseCase>(
        () => PostCommentUseCase(GetIt.I.get<CommentRepository>()));

    GetIt.I.registerFactoryParam<CommentBloc, String, CommentThreadType>(
      (param1, param2) => CommentBloc(
        getCommentsUseCase: GetIt.I.get<GetCommentsUseCase>(),
        threadId: param1,
        threadType: param2,
      )..add(GetCommentsEvent()),
    );
    GetIt.I.registerFactory<CommentLikeUnlikeBloc>(
      () => CommentLikeUnlikeBloc(
          likeCommentUseCase: GetIt.I.get<LikeCommentUseCase>(),
          unlikeCommentUseCase: GetIt.I.get<UnlikeCommentUseCase>()),
    );
    GetIt.I.registerFactory<CommentDeleteCubit>(
      () => CommentDeleteCubit(
          deleteCommentUseCase: GetIt.I.get<DeleteCommentUseCase>()),
    );
    GetIt.I.registerFactoryParam<CommentPostBloc, String, CommentThreadType>(
      (param1, param2) => CommentPostBloc(
          postCommentUseCase: GetIt.I.get<PostCommentUseCase>(),
          threadId: param1,
          threadType: param2),
    );
    GetIt.I.registerFactory<CommentUpdateBloc>(
      () => CommentUpdateBloc(
          editCommentUseCase: GetIt.I.get<UpdateCommentUseCase>()),
    );
  }

  static MultiBlocProvider commentBlocProvider(
          {@required Widget child,
          @required String threadId,
          @required CommentThreadType threadType}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<CommentBloc>(
            create: (context) =>
                GetIt.I.get<CommentBloc>(param1: threadId, param2: threadType),
          ),
          BlocProvider<CommentPostBloc>(
            create: (context) => GetIt.I
                .get<CommentPostBloc>(param1: threadId, param2: threadType),
          ),
          BlocProvider<CommentUpdateBloc>(
            create: (context) => GetIt.I.get<CommentUpdateBloc>(),
          ),
          BlocProvider<ThreadStatsCubit>(
            create: (context) => GetIt.I.get<ThreadStatsCubit>(
                param1: threadId, param2: threadType.value.toThreadType),
          ),
        ],
        child: child,
      );

  static MultiBlocProvider commentItemBlocProvider({
    @required Widget child,
  }) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<CommentLikeUnlikeBloc>(
            create: (context) => GetIt.I.get<CommentLikeUnlikeBloc>(),
          ),
          BlocProvider<CommentDeleteCubit>(
            create: (context) => GetIt.I.get<CommentDeleteCubit>(),
          ),
        ],
        child: child,
      );
}
