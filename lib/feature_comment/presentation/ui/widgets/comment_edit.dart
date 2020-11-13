import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/feature_comment/presentation/blocs/comment_update/comment_update_bloc.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/widgets/header.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class CommentEdit extends StatefulWidget {
  final CommentUIModel commentUIModel;

  const CommentEdit({Key key, @required this.commentUIModel}) : super(key: key);

  @override
  _CommentEditState createState() => _CommentEditState();
}

class _CommentEditState extends State<CommentEdit> {
  final TextEditingController _textEditingController = TextEditingController();
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.commentUIModel.entity.comment;
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    focusNode?.dispose();
    super.dispose();
  }

  void _submitComment(BuildContext context, String comment) {
    if (comment == null || comment.isEmpty) return;
    if (comment.length > 500) {
      context.showMessage('Comment too long. Max character limit is 500.');
      return;
    }
    // context.showMessage('Comment updating...');
    focusNode.unfocus();
    context.read<CommentUpdateBloc>().add(
          UpdateCommentEvent(
            widget.commentUIModel.entity.copyWith(comment: comment),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentUpdateBloc>(
      create: (context) => GetIt.I.get<CommentUpdateBloc>(),
      child: BlocListener<CommentUpdateBloc, CommentUpdateState>(
        listener: (context, state) {
          if (state is CommentUpdateSuccessState) {
            widget.commentUIModel.entity = widget.commentUIModel.entity
                .copyWith(comment: state.comment.comment);
            Navigator.pop(context);
            context.showMessage('Comment updated.');
          } else if (state is CommentUpdateErrorState) {
            context.showMessage(state.message);
          }
        },
        child: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(
                    title: 'Update: ${widget.commentUIModel.entity.comment}',
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: focusNode,
                            keyboardType: TextInputType.multiline,
                            textCapitalization: TextCapitalization.sentences,
                            minLines: 1,
                            maxLines: 4,
                            onSubmitted: (value) =>
                                _submitComment(context, value.trim()),
                            controller: _textEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write a comment'),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.paperPlane,
                            color: Colors.lightBlue,
                          ),
                          onPressed: () {
                            _submitComment(
                                context, _textEditingController.text.trim());
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
