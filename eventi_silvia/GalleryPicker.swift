
//

import SwiftUI
import PhotosUI

struct GalleryPicker : UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        // Creo il view controller x la galleria
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        // per rendere pickabili solo le foto
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        
        //x far funzionare i tasti devo usare un delegate che reagisce quando l'utente vi interagisce
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    //
    
    //Uso la classe che ho creato come coordinatore x fare da delegate
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        coordinator.galleryPicker = self
        return coordinator
    }
    
    
    
    
    // Classe da usare come delegate x l'interazione con il picker della galleria
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        var galleryPicker: GalleryPicker?
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Quando la foto viene selezionata, o cancel toccato, innanzitutto chiudo la modale della galleria
            picker.dismiss(animated: true)
            
            // Controllo se l'utente ha selezionato una foto o qualcos'altro
            guard let provider = results.first?.itemProvider else {
                //Nessuna foto selezionata
                return
            }
            
            // Chiedo la foto selezionata al provider
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){ image, error in
                    // L'immagine che è stata selezionata viene passata al picker
                    self.galleryPicker?.selectedImage = image as? UIImage
                }
            }
        }
    }
    
    
}
