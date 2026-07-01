// feature/image procesing/imagequbit_state.dart
// A simple, non-freezed implementation of the Imagequbit state

abstract class ImagequbitState {
  const ImagequbitState();
}

class ImagequbitInitial extends ImagequbitState {
  const ImagequbitInitial();
}

class ImagequbitLoading extends ImagequbitState {
  const ImagequbitLoading();
}

class ImagequbitSuccess extends ImagequbitState {
  const ImagequbitSuccess();
}

class ImagequbitError extends ImagequbitState {
  final String? message;
  const ImagequbitError([this.message]);
}
