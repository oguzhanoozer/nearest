import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../../../core/extension/string_extension.dart';
import '../viewmodel/product_comment_view_model.dart';
import '../../../product/contstants/image_path.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../product_detail/model/product_detail_model.dart';
import '../model/product_comment_model.dart';

class ProductCommentView extends StatelessWidget {
  final ProductDetailModel productDetailModel;
  ProductCommentView({Key? key, required this.productDetailModel})
      : super(key: key);

  final TextEditingController commentController = TextEditingController();

  Widget commentChild(ProductCommentViewModel viewModel,BuildContext context) {
    return ListView(
      children: [
        for (var comment in viewModel.productCommentList)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: null,
                child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: new BoxDecoration(
                        color: context.colorScheme.onSurfaceVariant,
                        borderRadius:
                            new BorderRadius.all(Radius.circular(50))),
                    child: ClipOval(
                      child: comment.userPhotoUrl != null &&
                              comment.userPhotoUrl!.isNotEmpty
                          ? Image.network(comment.userPhotoUrl!)
                          : Image.asset(ImagePaths.instance.hazelnut),
                    )),
              ),
              title: Text(
                comment.userName!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(comment.comment!),
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
                style: context.textTheme.headline6!
                    .copyWith(color: context.colorScheme.primary, fontWeight: FontWeight.bold),
              ),
              elevation: 1,
            ),
            body: Column(
              children: [
                Expanded(child: commentChild(viewModel,context)),
                ListTile(
                  title: TextFormField(
                    controller: commentController,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {},
                    autofocus: true,
                    onFieldSubmitted: (term) async {
                      if (term.isNotEmpty) {
                        await viewModel.addComment(
                            term, productDetailModel.productId!);
                        commentController.clear();
                      }
                    },
                    decoration: InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(8),
                        hintText: LocaleKeys.enterShopNameText.locale,
                        hintStyle: TextStyle(
                          color: context.colorScheme.onSecondary.withOpacity(0.5),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        prefixIcon: Icon(Icons.comment,
                            size: context.dynamicHeight(0.03)),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.cancel_sharp,
                              size: context.dynamicHeight(0.03)),
                          onPressed: () {
                            commentController.clear();
                          },
                        )),
                  ),
                )
              ],
            ),
          );
        });
  }
}
