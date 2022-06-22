import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:nearest_shops/view/product/input_text_decoration.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/service/firestorage/enum/document_collection_enums.dart';
import '../../../product/contstants/image_path.dart';
import '../../../product/image/image_network.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../viewmodel/product_comment_view_model.dart';

class ProductCommentView extends StatelessWidget {
  final ProductDetailModel productDetailModel;
  ProductCommentView({Key? key, required this.productDetailModel}) : super(key: key);

  final TextEditingController commentController = TextEditingController();

  Widget commentChild(ProductCommentViewModel viewModel, BuildContext context) {
    return ListView(
      children: [
        for (var comment in viewModel.productCommentList)
          Padding(
            padding: context.paddingLow,
            child: ListTile(
              leading: SizedBox(
                  height: context.dynamicHeight(0.1),
                  width: context.dynamicHeight(0.1),
                  child: ClipOval(
                      child: comment.userPhotoUrl != null && comment.userPhotoUrl!.isNotEmpty
                          ? buildImageNetwork(comment.userPhotoUrl!, context)
                          : Icon(Icons.person))),
              title: Text(comment.userName ?? ContentString.USER.rawValue, style: titleTextStyle(context)),
              subtitle: Text(
                comment.comment!,
                style: inputTextStyle(context),
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductCommentViewModel>(
        viewModel: ProductCommentViewModel(),
        onModelReady: (model) {
          model.init(productId: productDetailModel.productId);
          model.setContext(context);
        },
        onPageBuilder: (context, ProductCommentViewModel viewModel) {
          return Scaffold(
            key: viewModel.scaffoldState,
            appBar: AppBar(
              title: Text(
                LocaleKeys.commentsText.locale,
                style: context.textTheme.headline6!.copyWith(color: context.colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold),
              ),
              elevation: 1,
            ),
            body: Column(
              children: [
                Expanded(child: commentChild(viewModel, context)),
                ListTile(
                  title: TextFormField(
                    controller: commentController,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {},
                    autofocus: true,
                    onFieldSubmitted: (term) async {
                      if (term.isNotEmpty) {
                        await viewModel.addComment(term, productDetailModel.productId!);
                        commentController.clear();
                      }
                    },
                    decoration: buildCommentTextFieldDecoration(context),
                  ),
                )
              ],
            ),
          );
        });
  }

  InputDecoration buildCommentTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        isDense: true,
        contentPadding: context.paddingLow,
        hintText: LocaleKeys.enterShopNameText.locale,
        hintStyle: TextStyle(
          color: context.colorScheme.primary,
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
        prefixIcon: Icon(Icons.comment, color: context.colorScheme.onSurfaceVariant, size: context.dynamicHeight(0.03)),
        border: OutlineInputBorder(borderRadius: context.normalBorderRadius / 2, borderSide: BorderSide(style: BorderStyle.solid, width: 0.5)),
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel_sharp, size: context.dynamicHeight(0.03), color: context.colorScheme.onSurfaceVariant),
          onPressed: () {
            commentController.clear();
          },
        ));
  }
}
