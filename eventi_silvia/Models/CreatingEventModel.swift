//
//  CreateEventModel.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 06/12/22.
//

import Foundation
import CoreLocation
import UIKit

class CreatingEventModel: ObservableObject {
    @Published var nome = ""
    @Published var descrizione = ""
    @Published var price = ""
    @Published var data = Date()
    @Published var address = ""
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var photo: UIImage?
    //per chiudere le pagine
    @Published var isCreated = false
}
extension CreatingEventModel {
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: self.data)
    }
    var dateStringForServer: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self.data)
    }
}
