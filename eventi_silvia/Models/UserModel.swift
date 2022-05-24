//
//  UserModel.swift
//  eventi_silvia
//
//  Created by iedstudent on 17/05/22.
//

import Foundation

struct UserModel: Codable {
    let id:Int?
    let authToken:String?
    let email:String?
    let firstName:String?
    let lastName:String?
    let avatarUrl:String?
    let birthDate:String?
    let city:String?
    let money:Int?
    let createdAt:String?
    let updatedAt:String?
}
