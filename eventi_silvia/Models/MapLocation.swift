//
//  MapLocation.swift
//  eventi_silvia
//
//  Created by iedstudent on 21/06/22.
//

import Foundation
import CoreLocation

struct MapLocation: Identifiable {
    //id univoco per ogni oggetto che creiamo 
    var id = UUID()
    var name = ""
    var coordinate = CLLocationCoordinate2D()
}
