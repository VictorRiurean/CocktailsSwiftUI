//
//  ImagePicker.swift
//  CocktailsSwiftUI
//
//  Created by Victor Rîurean on 08/02/2023.
//

import PhotosUI
import SwiftUI
/// SwiftUI doesn't support PHPickerViewController out of the box so we
/// need to create this wrapper struct in order to interface with it
/// https://www.hackingwithswift.com/books/ios-swiftui/wrapping-a-uiviewcontroller-in-a-swiftui-view
struct ImagePicker: UIViewControllerRepresentable {
    
    // MARK: State
    
    @Binding var image: UIImage?
    
    
    // MARK: Protocol methods

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = context.coordinator
        
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }
    
    
    // MARK: Coordinator

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
