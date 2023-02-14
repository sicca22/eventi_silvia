//
//  MapView.swift
//  Eventi Balistreri
//
//  Created by Balistreri Davide on 29/11/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var coordinate: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.mapTapRecognizer(_:))
            )
        )
        
        return view
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        // Aggiorno i pin presenti sulla mappa
        view.removeAnnotations(view.annotations)
        
        guard let coordinate = coordinate else { return }
        
        // Aggiungo il pin sulla mappa
        let pin = MapPin()
        pin.coordinate = coordinate
        view.addAnnotation(pin)
        
        // Sposto la nuova telecamera per fare l'animazione di zoom sul pin
        let camera = view.camera.copy() as! MKMapCamera
        camera.centerCoordinate = coordinate
        
        // Cambio lo zoom se è troppo lontano
        let altitude: CLLocationDistance = 1000 // metri da terra
        if camera.altitude > altitude {
            camera.altitude = altitude
        }
        
        // Animazione di spostamento della telecamera
        view.setCamera(camera, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class MapPin: NSObject, MKAnnotation {
        var title: String?
        var subtitle: String?
        var coordinate = CLLocationCoordinate2D()
    }
    
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        let parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        @objc func mapTapRecognizer(_ sender: UIGestureRecognizer) {
            let mapView = sender.view as? MKMapView
            
            // Prendo il punto X e Y toccato sulla mappa dall'utente
            let tapLocation = sender.location(in: mapView)
            
            // Converto il punto toccato in coordinate geografiche (CLLocationCoordinate2D)
            parent.coordinate = mapView?.convert(tapLocation, toCoordinateFrom: sender.view)
        }
        
    }
}

