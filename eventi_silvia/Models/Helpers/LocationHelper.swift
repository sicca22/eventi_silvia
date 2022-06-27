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
}

