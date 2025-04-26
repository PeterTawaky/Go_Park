import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:smart_garage_final_project/cached/cache_helper.dart';
import 'package:smart_garage_final_project/core/utils/app_assets.dart';
import 'package:smart_garage_final_project/core/utils/keys_manager.dart';
import 'package:smart_garage_final_project/image_uploader.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageState(image: Assets.imagesNnnRemovebgPreview));

  uploadImage({required ImageSource imageSource}) async {
    ImageUploader.uploadImage(imageSource: imageSource);
    emit(
      ImageState(
        image:
            CachedData.getData(key: KeysManager.profilePhoto) ??
            Assets.imagesNnnRemovebgPreview,
      ),
    );
  }
}
