//
//  UserModel.swift
//  eventi_silvia
//
//  Created by iedstudent on 17/05/22.
//

import Foundation



struct UserModel: Codable {
    var id:Int?
    var authToken:String?
    var email:String?
    var firstName:String?
    var lastName:String?
    var avatarUrl:String?
    var birthDate:String?
    var city:String?
    var money:Int?
    var createdAt:String?
    var updatedAt:String?
    var eventsCount:Int?
    var ar: ARContent?
    
    //var fullName: 
}
//var fullName:
extension UserModel {
    
    var fullName: String {
        
        if let nome = firstName , let cognome = lastName {
            return "\(nome) \(cognome)"
        }
        else if let nome = firstName {
            return nome
        }
        else if let cognome = firstName {
            return cognome
        }
        return ""
    }
}


