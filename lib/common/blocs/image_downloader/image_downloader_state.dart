part of 'image_downloader_bloc.dart';

abstract class ImageDownloaderState extends Equatable {
  const ImageDownloaderState();
}

class ImageDownloaderInitial extends ImageDownloaderState {
  @override
  List<Object> get props => [];
}





// Loading state for downloading an image
class DownloadImageLoading extends ImageDownloaderState {
  @override
  List<Object?> get props => [];
}

// Success state for downloading an image
class DownloadImageSuccess extends ImageDownloaderState {
  final String imagePath;

  DownloadImageSuccess(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

// Failure state for downloading an image
class DownloadImageFailure extends ImageDownloaderState {
  final String error;

  DownloadImageFailure(this.error);

  @override
  List<Object?> get props => [error];
}
