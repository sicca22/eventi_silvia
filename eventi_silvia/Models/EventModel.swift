//
//  EventModel.swift
//  eventi_silvia
//
//  Created by iedstudent on 24/05/22.
//

import Foundation
struct EventModel: Codable,  Identifiable {
    
    
    var id:Int?
    var name:String?
    var description:String?
    var date:String?
    var categoryName:String?
    var attendeesCount:Int?
    var coverUrl:String?
    var price:Int?
    var address:String?
    var lat:Double?
    var lng:Double?
    var createdAt:String?
    var updatedAt:String?
    var viewsCount:Int?
    var commentsCount:Int?
    var likesCount:Int?
    var eventsCount:Int?
    var user:UserModel?
    
    
}

struct EventResponse: Codable {
    let error:ErrorModel?
    let data: [EventModel]?
}

extension EventModel {
    //static var eventodiProva: EventModel{
      //  return try
  //  }
    
    
    var priceString:String {
        //converto il price in decimali cosi da non averre un arrotondamento troppo alto 
        var priceInEuro = Double(self.price ?? 0)
        //converto il price in euro
         priceInEuro = priceInEuro / 100
        
        if priceInEuro == 0 {
            return "FREE"
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
}
