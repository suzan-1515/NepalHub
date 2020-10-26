import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/outline_rounded_button.dart';
import 'package:samachar_hub/feature_report/domain/entities/report_thread_type.dart';
import 'package:samachar_hub/feature_report/presentation/blocs/report_cubit.dart';
import 'package:samachar_hub/feature_report/utils/provider.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class Report extends StatelessWidget {
  final String threadId;
  final ReportThreadType threadType;

  const Report({
    Key key,
    @required this.threadId,
    @required this.threadType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ReportProvider.reportBlocProvider(
      child: Builder(
        builder: (context) => BlocListener<ReportCubit, ReportState>(
          listener: (context, state) {
            if (state is ReportSuccessState) {
              context.showMessage('Report Successful.');
            } else if (state is ReportErrorState) {
              context.showMessage(state.message);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Report',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(),
                Text(
                  'You can report this article with a reason below',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 4,
                ),
                Wrap(
                  spacing: 4.0,
                  children: [
                    ReportOptionButton(
                      text: 'Fake news',
                      onTap: () {
                        context.bloc<ReportCubit>().report(
                            threadId: threadId,
                            threadType: threadType,
                            tag: 'Fake news');
                        Navigator.pop(context);
                      },
                    ),
                    ReportOptionButton(
                      text: 'Clickbait',
                      onTap: () {
                        context.bloc<ReportCubit>().report(
                            threadId: threadId,
                            threadType: threadType,
                            tag: 'Clickbait');
                        Navigator.pop(context);
                      },
                    ),
                    ReportOptionButton(
                      text: 'Old or repetative',
                      onTap: () {
                        context.bloc<ReportCubit>().report(
                            threadId: threadId,
                            threadType: threadType,
                            tag: 'Old or repetative news');
                        Navigator.pop(context);
                      },
                    ),
                    ReportOptionButton(
                      text: 'Adult',
                      onTap: () {
                        context.bloc<ReportCubit>().report(
                            threadId: threadId,
                            threadType: threadType,
                            tag: 'Adult');
                        Navigator.pop(context);
                      },
                    ),
                    ReportOptionButton(
                      text: 'Other',
                      onTap: () {
                        context.bloc<ReportCubit>().report(
                            threadId: threadId,
                            threadType: threadType,
                            tag: 'Other');
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
