//
//  UserModel.swift
//  Party
//
//  Created by Александр Цветков on 26.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

class UserRequest: Codable {
    var phoneNumber: String
    var firstName: String
    var secondName: String
    var birthYear: String
    var birthMonth: String
    var birthDay: String
    var locationId: String
    var password: String
    var email: String
    
    public init(phoneNumber: String, firstName: String, secondName: String, birthYear: String, birthMonth: String, birthDay: String, locationId: String, password: String, email: String) {
        self.phoneNumber = phoneNumber
        self.firstName = firstName
        self.secondName = secondName
        self.birthYear = birthYear
        self.birthMonth = birthMonth
        self.birthDay = birthDay
        self.locationId = locationId
        self.password = password
        self.email = email
    }
    
    init(fromUser user: UserResponse) {
        let date = user.birthdayDate.split(separator: "-")
        self.phoneNumber = user.phoneNumber
        self.firstName = user.firstName
        self.secondName = user.secondName
        self.birthYear = String(date[0])
        self.birthMonth = String(date[1])
        self.birthDay = String(date[2])
        self.locationId = "\(user.locationId)"
        self.password = user.password
        self.email = user.emailAddress
    }
}

class UserResponse: Codable {
    var firstName: String
    var secondName: String
    var accessToken: String?
    var refreshToken: String?
    var birthdayDate: String
    var emailAddress: String
    var phoneNumber: String
    var password: String
    var locationId: String
    var id: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.secondName = try container.decode(String.self, forKey: .firstName)
        self.accessToken = try container.decode(String.self, forKey: .firstName)
        self.refreshToken = try container.decode(String.self, forKey: .firstName)
        self.birthdayDate = try container.decode(String.self, forKey: .firstName)
        self.emailAddress = try container.decode(String.self, forKey: .firstName)
        self.phoneNumber = try container.decode(String.self, forKey: .firstName)
        self.password = try container.decode(String.self, forKey: .firstName)
        
        do {
            self.locationId = try container.decode(String.self, forKey: .locationId)
        } catch  {
            let locationIdInt = try container.decode(Int.self, forKey: .locationId)
            self.locationId = "\(locationIdInt)"
        }
        do {
            self.id = try container.decode(String.self, forKey: .id)
        } catch {
            let idInt = try container.decode(Int.self, forKey: .id)
            self.id = "\(idInt)"
        }
    }
    
    enum CodinKeys: String, CodingKey {
        case firstName = "first_name"
        case secondName = "second_name"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case birthdayDate = "birthday_date"
        case emailAddress = "email_address"
        case phoneNumber = "phone_number"
        case password = "password"
        case locationId = "location_id"
        case id = "id"
    }
}
