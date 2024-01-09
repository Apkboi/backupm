part of 'image_downloader_bloc.dart';

// Base class for Image Downloader events
abstract class ImageDownloaderEvent extends Equatable {
  const ImageDownloaderEvent();
}

// Event class for downloading an image
class DownloadImageEvent extends ImageDownloaderEvent {
  final String url;

  DownloadImageEvent(this.url);

  @override
  List<Object?> get props => [url];
}
