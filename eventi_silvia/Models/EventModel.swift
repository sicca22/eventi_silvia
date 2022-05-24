//
//  EventModel.swift
//  eventi_silvia
//
//  Created by iedstudent on 24/05/22.
//

import Foundation
struct EventModel: Codable,  Identifiable {
    let id:Int?
    let name:String?
    let description:String?
    let date:String?
    let coverUrl:String?
    
    
}

struct EventResponse: Codable {
    let error:ErrorModel?
    let data: [EventModel]?
}
