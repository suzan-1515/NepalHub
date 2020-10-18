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
        RepositoryProvider(
          create: (context) => CommentRepository(
            CommentRemoteDataSource(
              CommentRemoteService(
                context.repository<HttpManager>(),
              ),
            ),
            context.repository<AnalyticsService>(),
            context.repository<AuthRepository>(),
          ),
        ),
      ];
  static List<RepositoryProvider> get comment2RepositoryProviders => [
        RepositoryProvider(
          create: (context) =>
              DeleteCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetCommentsUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              LikeCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UnlikeCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              UpdateCommentUseCase(context.repository<CommentRepository>()),
        ),
        RepositoryProvider(
          create: (context) =>
              PostCommentUseCase(context.repository<CommentRepository>()),
        ),
      ];
  static BlocProvider commentBlocProvider({
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
        ),
        child: child,
      );
}
