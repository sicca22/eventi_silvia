//
//  GalleryPicker.swift
//  eventi_silvia
//
//  Created by iedstudent on 21/10/22.
//

import SwiftUI
import PhotosUI
struct GalleryPicker:UIViewControllerRepresentable {
    //varisbile che viene modificata quando l'utente seleziona le immagini dal picker
    @Binding var selectedImage: UIImage?
    func makeUIViewController(context: Context) -> some UIViewController {
        //creo il view controller
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let picker =  PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        coordinator.galleryPicker = self
        return Coordinator()
    }
    class Coordinator:NSObject, PHPickerViewControllerDelegate{
        var galleryPicker: GalleryPicker?
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            //chiudo la modale del ticket
            picker.dismiss(animated: true)
            
            //controlliamo se l'utente ha effetivamente selezionato qualcosa
            guard let provider = results.first?.itemProvider else {
                //nessuna foto selezionata quindi interrompo l'esecuzione del codice
                return
            }
            //è stata selezionata una fot, prendo un immagine chiedendola al provider
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self ){ image , error in
                    
                    self.galleryPicker?.selectedImage = image as? UIImage
                }
            }
        }
    }
}
