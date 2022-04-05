// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddProductViewModel on _AddProductViewModelBase, Store {
  final _$pickedFileAtom = Atom(name: '_AddProductViewModelBase.pickedFile');

  @override
  List<XFile> get pickedFile {
    _$pickedFileAtom.reportRead();
    return super.pickedFile;
  }

  @override
  set pickedFile(List<XFile> value) {
    _$pickedFileAtom.reportWrite(value, super.pickedFile, () {
      super.pickedFile = value;
    });
  }

  final _$tempFileAtom = Atom(name: '_AddProductViewModelBase.tempFile');

  @override
  ObservableList<File> get tempFile {
    _$tempFileAtom.reportRead();
    return super.tempFile;
  }

  @override
  set tempFile(ObservableList<File> value) {
    _$tempFileAtom.reportWrite(value, super.tempFile, () {
      super.tempFile = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AddProductViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isImageSelectedAtom =
      Atom(name: '_AddProductViewModelBase.isImageSelected');

  @override
  bool get isImageSelected {
    _$isImageSelectedAtom.reportRead();
    return super.isImageSelected;
  }

  @override
  set isImageSelected(bool value) {
    _$isImageSelectedAtom.reportWrite(value, super.isImageSelected, () {
      super.isImageSelected = value;
    });
  }

  final _$_groupIdAtom = Atom(name: '_AddProductViewModelBase._groupId');

  @override
  int get _groupId {
    _$_groupIdAtom.reportRead();
    return super._groupId;
  }

  @override
  set _groupId(int value) {
    _$_groupIdAtom.reportWrite(value, super._groupId, () {
      super._groupId = value;
    });
  }

  final _$showProductImageAsyncAction =
      AsyncAction('_AddProductViewModelBase.showProductImage');

  @override
  Future<void> showProductImage(List<String> productListImages) {
    return _$showProductImageAsyncAction
        .run(() => super.showProductImage(productListImages));
  }

  final _$selectImageAsyncAction =
      AsyncAction('_AddProductViewModelBase.selectImage');

  @override
  Future<void> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  final _$addProductAsyncAction =
      AsyncAction('_AddProductViewModelBase.addProduct');

  @override
  Future<void> addProduct(List<File> pickedFile, bool isUpdate,
      {ProductDetailModel? productModel}) {
    return _$addProductAsyncAction.run(() =>
        super.addProduct(pickedFile, isUpdate, productModel: productModel));
  }

  final _$_AddProductViewModelBaseActionController =
      ActionController(name: '_AddProductViewModelBase');

  @override
  void changeGroupId(int value) {
    final _$actionInfo = _$_AddProductViewModelBaseActionController.startAction(
        name: '_AddProductViewModelBase.changeGroupId');
    try {
      return super.changeGroupId(value);
    } finally {
      _$_AddProductViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteSelectedImage(int index) {
    final _$actionInfo = _$_AddProductViewModelBaseActionController.startAction(
        name: '_AddProductViewModelBase.deleteSelectedImage');
    try {
      return super.deleteSelectedImage(index);
    } finally {
      _$_AddProductViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isImageSelectedChange() {
    final _$actionInfo = _$_AddProductViewModelBaseActionController.startAction(
        name: '_AddProductViewModelBase.isImageSelectedChange');
    try {
      return super.isImageSelectedChange();
    } finally {
      _$_AddProductViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingChange() {
    final _$actionInfo = _$_AddProductViewModelBaseActionController.startAction(
        name: '_AddProductViewModelBase.isLoadingChange');
    try {
      return super.isLoadingChange();
    } finally {
      _$_AddProductViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pickedFile: ${pickedFile},
tempFile: ${tempFile},
isLoading: ${isLoading},
isImageSelected: ${isImageSelected}
    ''';
  }
}
