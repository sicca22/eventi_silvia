//
//  ResponseModel.swift
//  eventi_silvia
//
//  Created by iedstudent on 17/05/22.
//

import Foundation
struct ResponseModel: Codable {
    let error: ErrorModel?
    let data: UserModel?
}
struct ErrorModel: Codable {
    let code: Int?
    let description: String?
}
