import PhotosUI
import SwiftUI


struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    
    @ObservedObject var mediaItems: PickedMediaItems
    var didFinishPicking: (_ didSelectItems: Bool) -> Void
    
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        var photoPicker: PhotoPicker
        
        init(with photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            photoPicker.didFinishPicking(!results.isEmpty)
            
            guard !results.isEmpty else {
                return
            }
            
            let itemProvider = results[0].itemProvider
            self.getPhoto(from: itemProvider)
        }
        private func getPhoto(from itemProvider: NSItemProvider) {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.photoPicker.mediaItems.append(item: PhotoPickerModel(with: image))
                        }
                    }
                }
            }
        }
    }
    
}
