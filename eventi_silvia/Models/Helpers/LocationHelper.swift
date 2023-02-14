//
//  LocationHelper.swift
//  eventi_silvia
//
//  Created by iedstudent on 27/06/22.
//

import Foundation

import CoreLocation
import MapKit

// questo file raggruppa tutte le funzioni che servono per navigare
struct LocationHelper {
    static func navigateTo(coordinate: CLLocationCoordinate2D, title: String ){
        //controllare se le cordinate sono valide
        if check(coordinate: coordinate) == false {
            return
        }
        // il secondo coordinate è iul nome che ho scleto io
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        //apro le mappe di apple
        
        mapItem.openInMaps(launchOptions: nil)
    }
    static func check(coordinate: CLLocationCoordinate2D?) -> Bool {
        //1. controllo se l'oggetto esiste
        if coordinate == nil {
            return false
        }
        //2. controllo con la funzione apple
        if CLLocationCoordinate2DIsValid(coordinate!) == false {
            return false
        }
        //3. controllo se sono in metto all'oceano pacifico
        if coordinate?.latitude == 0 || coordinate?.longitude == 0 {
            return false
        }
        //controlli superati
        return true
    }

    
    static func address(from coordinate: CLLocationCoordinate2D?) async -> String? {
        guard let coordinate = coordinate else { return nil }
        
        // Converto le coordinate geografiche nel nome dell'indirizzo
        let geocoder = CLGeocoder()
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let placemarks = try? await geocoder.reverseGeocodeLocation(location)
        
        // Solitamente il geocoding restituisce un array con un solo risultato
        return address(from: placemarks?.first)
    }
    
    static func coordinate(from address: String?) async -> CLLocationCoordinate2D? {
        // Converto l'indirizzo inserito dall'utente in coordinate geografiche
        let geocoder = CLGeocoder()
        
        let placemarks = try? await geocoder.geocodeAddressString(address ?? "")
        
        // Solitamente il geocoding restituisce un array con un solo risultato
        return placemarks?.first?.location?.coordinate
    }
    
    /// Questa funzione restituisce una stringa composta dell'indirizzo partendo da un CLPlacemark.
    private static func address(from placemark: CLPlacemark?) -> String {
        // Creo un array per inserire tutte le proprietÃ  dell'indirizzo che mi servono ed esistono
        var components: [String] = []
        
        // Aggiungo il nome della via (solo se il geocoder Ã¨ riuscito a determinarla)
        if let thoroughfare = placemark?.thoroughfare {
            components.append(thoroughfare)
        }
        
        // Aggiungo il civico
        if let subThoroughfare = placemark?.subThoroughfare {
            components.append(subThoroughfare)
        }
        
        // Aggiungo il CAP
        if let postalCode = placemark?.postalCode {
            components.append(postalCode)
        }
        
        // Aggiungo la cittÃ
        if let locality = placemark?.locality {
            components.append(locality)
        }
        
        // Aggiungo la regione
        // if let administrativeArea = placemark?.administrativeArea {
        //     components.append(administrativeArea)
        // }
        
        // Aggiungo lo stato
        if let country = placemark?.country {
            components.append(country)
        }
        
        // Creo una stringa con gli elementi presenti sull'array, separandoli con una virgola
        return components.joined(separator: ", ")
    }
    
    private init() {}
    
}

extension CLLocationCoordinate2D: Equatable {
    static public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

