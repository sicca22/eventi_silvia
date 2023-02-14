//
//  EventModel.swift
//  eventi_silvia
//
//  Created by iedstudent on 24/05/22.
//

import Foundation
import CoreLocation

struct EventModel: Codable, Identifiable {
    
    
    var id: Int?
    var name: String?
    var description: String?
    var date: String?
    var coverUrl: String?
    
    var price: Int?
    var address: String?
    var lat: Double?
    var lng: Double?
    var createdAt: String?
    var updatedAt: String?
    var viewsCount: Int?
    var likesCount: Int?
    var eventsCount: Int?
    var user: UserModel?
    var categoryName: String?
    var attendeesCount: Int?
    
    var quantity: Int?
    // Funzione che permette di modificare (mutare) i campi della struct
    mutating func updateQuantity(_ quantity: Int) {
        self.quantity = quantity
    }
    
}

struct EventResponse: Codable {
    var error: ErrorModel?
    var data: [EventModel]?
}

// Per aggiungere altre funzionalità estendo la classe dell'evento

extension EventModel: Equatable {
    static func == (lhs: EventModel, rhs: EventModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension EventModel {
    //static var eventodiProva: EventModel{
      //  return try
  //  }
    var nameAndQuantity: String {
        return "\(quantity ?? 1)x \(name ?? " ")"
    }
    
    var totalPriceString: String {
        return "100,00"
    }
    
    var priceString:String {
        //converto il price in decimali cosi da non averre un arrotondamento troppo alto
        var priceInEuro = Double(self.price ?? 0)
        //converto il price in euro
         priceInEuro = priceInEuro / 100
        
        if priceInEuro == 0 {
            return "Gratis"
        }
        //formatto la stringa con due numeri dopo la virgola
        let priceFormatter = String.init(format: "%.2f €", priceInEuro)
        
        //sostyituisco i punti con le virgole
        return priceFormatter.replacingOccurrences(of: ".", with: ",")
       
    }
    
    var dayString:String {
       let formatter =  DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:SS"
        
        //converto la data dell'evento da string a date
        let date = formatter.date(from: self.date ?? "")
        
        formatter.dateFormat = "dd"
        return  formatter.string(from:date ?? Date())
    }
    
    var monthString:String {
       let formatter =  DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:SS"
        
        //converto la data dell'evento da string a date
        let date = formatter.date(from: self.date ?? "")
        
        formatter.dateFormat = "MMM"
        return  formatter.string(from:date ?? Date())
    }
    
    var timeString:String {
       let formatter =  DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:SS"
        
        //converto la data dell'evento da string a date
        let date = formatter.date(from: self.date ?? "")
        
        formatter.dateFormat = "HH:mm"
        return  formatter.string(from:date ?? Date())
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: self.lat ?? 0,
            longitude: self.lng ?? 0
        )
    }
    
    var mapLocation: MapLocation {
        return MapLocation(
            name:"",
            coordinate: self.coordinate,
            event: self
        )
    }
}
