import SwiftUI
import Photos

struct PhotoPickerModel: Identifiable {
    enum MediaType {
        case photo, video, livePhoto
    }
    
    var id: String
    var photo: UIImage?
    var url: URL?
    var livePhoto: PHLivePhoto?
    var mediaType: MediaType = .photo
    
    init(with photo: UIImage) {
        id = UUID().uuidString
        self.photo = photo
        mediaType = .photo
    }
}

class PickedMediaItems: ObservableObject {
    @Published var item: PhotoPickerModel?
    
    func append(item: PhotoPickerModel) {
        self.item = item
    }
}
