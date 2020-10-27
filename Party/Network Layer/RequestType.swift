//
//  RequestType.swift
//  Party
//
//  Created by Александр Цветков on 24.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

enum RequestType {
    case login
    case verify
    case refresh
    case logout
    case forgot
    case imageDownload
    case imageUpload
    case createEvent
    case updateEvent
    case getEvent
    case deleteEvent
    case updatePhoto
    case getUserDetails
    case updateUserDetails
    case changePassword
    case createLocation
    case getLocation
    case sendCode
    case checkCode
    case createUser
    case searchEvent
    
    func getPath() -> String {
        switch self {
        case .login:
            return "auth"
        case .verify:
            return "auth/verify"
        case .refresh:
            return "auth/refresh"
        case .logout:
            return "auth/logout"
        case .forgot:
            return "auth/forgot"
        case .imageDownload:
            return "image"
        case .imageUpload:
            return "image/upload"
        case .createEvent:
            return "user/event"
        case .updateEvent:
            return "user/event"
        case .getEvent:
            return "user/event"
        case .deleteEvent:
            return "user/event"
        case .updatePhoto:
            return "user/profile/photo"
        case .getUserDetails:
            return "user/profile"
        case .updateUserDetails:
            return "user/profile"
        case .changePassword:
            return "user/profile/password/change"
        case .createLocation:
            return "location/create"
        case .getLocation:
            return "location"
        case .sendCode:
            return "auth/phone"
        case .checkCode:
            return "auth/phone/code"
        case .createUser:
            return "user/profile/signup"
        case .searchEvent:
            return ""
        }
    }
    
    func getHTTPMethod() -> String {
        switch self {
        case .login:
            return "POST"
        case .verify:
            return "GET"
        case .refresh:
            return "POST"
        case .logout:
            return "POST"
        case .forgot:
            return "POST"
        case .imageDownload:
            return "GET"
        case .imageUpload:
            return "PUT"
        case .createEvent:
            return "PUT"
        case .updateEvent:
            return "PATCH"
        case .getEvent:
            return "GET"
        case .deleteEvent:
            return "DEL"
        case .updatePhoto:
            return "POST"
        case .getUserDetails:
            return "GET"
        case .updateUserDetails:
            return "PATCH"
        case .changePassword:
            return "POST"
        case .createLocation:
            return "PUT"
        case .getLocation:
            return "GET"
        case .sendCode:
            return "POST"
        case .checkCode:
            return "POST"
        case .createUser:
            return "POST"
        case .searchEvent:
            return "GET"
        }
    }
}

