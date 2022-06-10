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
    //var fullName: 
}
