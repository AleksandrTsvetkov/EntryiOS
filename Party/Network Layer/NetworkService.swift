//
//  NetworkService.swift
//  Party
//
//  Created by Александр Цветков on 23.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

class NetworkService {
    
    typealias SessionResult = (Result<Data, Error>) -> Void
    static let shared = NetworkService()
    fileprivate init() {}

    //MARK: - Auth
    func login(phoneNumber: String, password: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("phone_number", phoneNumber, false),
            ("password", password, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        print(parameters)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .login, parametersData: parametersData, completion: completion)
    }
    
    func verify(completion: @escaping SessionResult) {
        makeRequest(ofType: .verify, parametersData: nil, completion: completion)
    }
    
    func refresh(refreshToken: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("refresh_token", refreshToken, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .refresh, parametersData: parametersData, completion: completion)
    }
    
    func logout(completion: @escaping SessionResult) {
        makeRequest(ofType: .logout, parametersData: nil, completion: completion)
    }
    
    func forgot(phoneNumber: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("phone_number", phoneNumber, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .forgot, parametersData: parametersData, completion: completion)
    }
    
    //MARK: - Image methods
    func getImage(id: String, completion: @escaping SessionResult) {
        makeRequest(ofType: .imageDownload, parametersData: nil, completion: completion)
    }
    
    func uploadImage(imageContent: Data, completion: @escaping SessionResult) {
        makeRequest(ofType: .imageUpload, parametersData: imageContent, completion: completion)
    }
    
    //MARK: - Event methods
    func createEvent(_ event: Event, completion: @escaping SessionResult) {
        let price: String = event.price ?? "null"
        let ending: String = event.ending ?? "null"
        let shisha: String = event.shisha ?? "null"
        let age_bottom_limit: String = event.age_bottom_limit ?? "null"
        let age_top_limit: String = event.age_top_limit ?? "null"
        let count_bottom_limit: String = event.count_bottom_limit ?? "null"
        let count_top_limit: String = event.count_top_limit ?? "null"
        let parametersArray = [
            ("title", event.title, false),
            ("beginning", event.beginning, false),
            ("beginning", event.beginning, false),
            ("description", event.description, false),
            ("location_id", event.location_id, true),
            ("price", price, true),
            ("ending", ending, false),
            ("shisha", shisha, true),
            ("age_bottom_limit", age_bottom_limit, true),
            ("age_top_limit", age_top_limit, true),
            ("count_bottom_limit", count_bottom_limit, true),
            ("count_top_limit", count_top_limit, true),
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        print(parameters)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .createEvent, parametersData: parametersData, completion: completion)
    }
    
    func updateEvent(id: String, shisha: Bool, updatedParameters: String, completion: @escaping SessionResult) {
        let shishaString = shisha ? "true" : "false"
        let parametersArray = [
            ("event_id", id, true),
            ("shisha", shishaString, true)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .updateEvent, parametersData: parametersData, completion: completion)
    }
    
    func getEvent(id: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("event_id", id, true)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .getEvent, parametersData: parametersData, completion: completion)
    }
    
    func deleteEvent(id: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("event_id", id, true)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .deleteEvent, parametersData: parametersData, completion: completion)
    }
    
    //MARK: - User methods
    func updatePhoto(phoneNumber: String, urlString: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("phone_number", phoneNumber, false),
            ("url", urlString, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .updatePhoto, parametersData: parametersData, completion: completion)
    }
    
    func getUserDetails(completion: @escaping SessionResult) {
        makeRequest(ofType: .getUserDetails, parametersData: nil, completion: completion)
    }
    
    func updateUserDetails(updatedFields: Array<(String, String, Bool)>, completion: @escaping SessionResult) {
        var parameters = ""
        parameters.makeNewFields(rows: updatedFields)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .updateUserDetails, parametersData: parametersData, completion: completion)
    }
    
    func changePassword(password: String, newPassword1: String, newPassword2: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("password", password, false),
            ("new_password1", newPassword1, false),
            ("new_Password2", newPassword2, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .changePassword, parametersData: parametersData, completion: completion)
    }
    
    //MARK: - Location methods
    func createLocation(locationModel: Location, completion: @escaping SessionResult) {
        let parametersArray = [
            ("title", locationModel.title, false),
            ("city", locationModel.city, false),
            ("latitude", locationModel.latitude, true),
            ("longitude", locationModel.longitude, true)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        print(parameters)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .createLocation, parametersData: parametersData, completion: completion)
    }
    
    func getLocation(completion: @escaping SessionResult) {
        makeRequest(ofType: .getLocation, parametersData: nil, completion: completion)
    }
    
    //MARK: - SignUp methods
    func sendCode(phoneNumber: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("phone_number", phoneNumber, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .sendCode, parametersData: parametersData, completion: completion)
    }
    
    func checkCode(phoneNumber: String, code: String, completion: @escaping SessionResult) {
        let parametersArray = [
            ("phone_number", phoneNumber, false),
            ("code", code, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .checkCode, parametersData: parametersData, completion: completion)
    }
    
    func createUser(user: User, completion: @escaping SessionResult) {
        let parametersArray = [
            ("phone_number", user.phoneNumber, false),
            ("first_name", user.firstName, false),
            ("second_name", user.secondName, false),
            ("birth_year", user.birthYear, true),
            ("birth_month", user.birthMonth, true),
            ("birth_day", user.birthDay, true),
            ("location_id", user.locationId, true),
            ("password", user.password, false),
            ("email", user.email, false)
        ]
        var parameters = ""
        parameters.makeFields(rows: parametersArray)
        let parametersData = parameters.data(using: .utf8)
        makeRequest(ofType: .createUser, parametersData: parametersData, completion: completion)
    }
    
    //MARK: - Search methods
    func searchEvent(completion: @escaping SessionResult) {
        makeRequest(ofType: .searchEvent, parametersData: nil, completion: completion)
    }
    
    //MARK: - Supporting methods
    private func makeRequest(ofType type: RequestType, parametersData: Data?, completion: @escaping SessionResult) {
        let queryPart = type == .imageDownload ? "?file_id=" : ""
        let urlString = API.scheme + "://" + API.host + ":" + API.port + "/" + type.getPath() + queryPart
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        if type == .imageUpload { request.addValue("text/plain", forHTTPHeaderField: "Content-Type") }
        request.httpMethod = type.getHTTPMethod()
        if let parametersData = parametersData {
            request.httpBody = parametersData
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleSession(ofType: type, data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }
    
    private func handleSession(ofType type: RequestType, data: Data?, response: URLResponse?, error: Error?, completion: @escaping SessionResult) {
        DispatchQueue.main.async {
            if let error = error {
                print("\(error.localizedDescription) in \(#function) of type \(type)")
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Error with unwrapping response in \(#function) of type \(type)")
                completion(.failure(NetworkError.responseIsNil))
                return
            }
            guard (200...299).contains(response.statusCode) else {
                print("Status code is wrong: \(response.statusCode) in \(#function) of type \(type)")
                completion(.failure(NetworkError.wrongStatusCode))
                return
            }
            guard let data = data else {
                print("Failed to unwrap data in \(#function) of type \(type)")
                completion(.failure(NetworkError.dataIsNil))
                return
            }
            completion(.success(data))
            guard let dataString = String(data: data, encoding: .utf8) else { return }
            print(dataString)
        }
    }
}
