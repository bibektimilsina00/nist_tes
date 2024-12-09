import 'package:nist_tes/app/enum/enum.dart';

MediaType getFileType(String url) {
  if (url.endsWith('.pdf')) {
    return MediaType.image;
  } else if (url.endsWith('.doc') || url.endsWith('.docx')) {
    return MediaType.word;
  } else if (url.endsWith('.xls') || url.endsWith('.xlsx')) {
    return MediaType.exel;
  } else if (url.endsWith('.ppt') || url.endsWith('.pptx')) {
    return MediaType.ptt;
  } else if (url.endsWith('.jpg') ||
      url.endsWith('.jpeg') ||
      url.endsWith('.png')) {
    return MediaType.image;
  } else if (url.endsWith('.mp4') ||
      url.endsWith('.avi') ||
      url.endsWith('.mkv')) {
    return MediaType.video;
  } else if (url.endsWith('.mp3') ||
      url.endsWith('.wav') ||
      url.endsWith('.flac')) {
    return MediaType.audio;
  } else {
    return MediaType.other;
  }
}
