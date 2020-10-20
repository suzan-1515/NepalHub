import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_comment/data/datasources/remote/comment_remote_data_source.dart';
import 'package:samachar_hub/feature_comment/data/repositories/comment_repository.dart';
import 'package:samachar_hub/feature_comment/data/services/comment_remote_service.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/usecases.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_bloc.dart';

class CommentProvider {
  CommentProvider._();
  static List<RepositoryProvider> get commentRepositoryProviders => [
        RepositoryProvider<CommentRemoteService>(
          create: (context) => CommentRemoteService(
            context.repository<HttpManager>(),
          ),
        ),
        RepositoryProvider<CommentRemoteDataSource>(
          create: (context) => CommentRemoteDataSource(
            context.repository<CommentRemoteService>(),
          ),
        ),
        RepositoryProvider<CommentRepository>(
          create: (context) => CommentRepository(
            context.repository<CommentRemoteDataSource>(),
            context.repository<AnalyticsService>(),
            context.repository<AuthRepository>(),
          ),
        ),
        RepositoryProvider<DeleteCommentUseCase>(
          create: (context) =>
              DeleteCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider<GetCommentsUseCase>(
          create: (context) =>
              GetCommentsUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider<LikeCommentUseCase>(
          create: (context) =>
              LikeCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider<UnlikeCommentUseCase>(
          create: (context) =>
              UnlikeCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider<UpdateCommentUseCase>(
          create: (context) =>
              UpdateCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider<PostCommentUseCase>(
          create: (context) =>
              PostCommentUseCase(context.repository<CommentRepository>()),
        ),
      ];
  static BlocProvider<CommentBloc> commentBlocProvider({
    @required Widget child,
    @required String threadId,
    @required CommentThreadType threadType,
    @required String threadTitle,
    @required int likeCount,
    @required int commentCount,
  }) =>
      BlocProvider<CommentBloc>(
        create: (context) => CommentBloc(
          getCommentsUseCase: context.repository<GetCommentsUseCase>(),
          threadId: threadId,
          threadTitle: threadTitle,
          threadType: threadType,
          likeCount: likeCount,
          commentCount: commentCount,
        )..add(GetCommentsEvent()),
        child: child,
      );
}
