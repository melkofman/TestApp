//
//  Services.swift
//  TestApp
//
//  Created by Melanie Kofman on 26.08.2022.
//

import Foundation
import UIKit
class Services {
    var idUser: String?
    var email: String?
    var pswd: String?
    func registerUser(email: String, firstname: String, lastname: String, password: String, comletion: @escaping (Bool) -> Void, viewController: UIViewController) {
        let session = URLSession.shared
        guard let url = URL(string: "http://94.127.67.113:8099/registerUser") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("text/html; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let parametrs = ["email":email, "firstname":firstname, "lastname":lastname, "password":password]
        guard let data = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {return}
        
        request.httpBody = data
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard let decoded = try? JSONDecoder().decode(User.self, from: data) else {return}
                self.idUser = decoded.id
                self.email = decoded.email
                self.pswd = decoded.password
                comletion(true)
            } catch {
                let stringError = String(error.localizedDescription)
                DispatchQueue.main.async {
                    viewController.showToast(message: stringError)
                    
                }
                comletion(false)
                
            }
        }.resume()
    }
    
    func checkLogin(email: String, password: String, comletion: @escaping (Bool) -> Void, viewController: UIViewController) {
        let session = URLSession.shared
        guard let url = URL(string: "http://94.127.67.113:8099/checkLogin") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parametrs = ["email":email, "password":password]
        guard let data = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {return}
        
        request.httpBody = data
        
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
                
            }
            guard let data = data else {return}
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObject)
                comletion(true)
            } catch {
                let stringError = String(error.localizedDescription)
                DispatchQueue.main.async {
                    viewController.showToast(message: stringError)
                }
                comletion(false)
                
            }
        }.resume()
    }
    
    func uploadAvatar(image: Data) {
        
        let imageUploadRequest = ImageRequest(type: image.base64EncodedString(), src: self.idUser ?? "")
        uploadAvatarToServer(request: imageUploadRequest)
    }
    private func uploadAvatarToServer(request: ImageRequest) {
        
        let session = URLSession.shared
        guard let url = URL(string: "http://94.127.67.113:8099/uploadAvatar") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        let lineBreak = "\r\n"
        
        var data = Data()
        
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
        
        data.append("--\(boundary)\r\n" .data(using: .utf8)!)
        data.append("content-disposition: form-data; name=\"type\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        data.append(request.type .data(using: .utf8)!)
        data.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
        data.append("content-disposition: form-data; name=\"src\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        data.append("\(request.src + lineBreak)" .data(using: .utf8)!)
        
        data.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
        
        urlRequest.addValue("\(data.count)", forHTTPHeaderField: "content-length")
        urlRequest.httpBody = data
        session.dataTask(with: urlRequest) {( data, HTTPURLResponse, error) in
            if (error == nil && data != nil) {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
                    print("jsonObject\(jsonObject)")
                    
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return pred.evaluate(with: email)
    }
    
    func updateProfile(viewController: UIViewController, firstname: String, lastname: String, birthdate: String, preferences: [String], organization: String, position: String, birth_place: String, middlename: String) {
        let session = URLSession.shared
        guard let url = URL(string: "http://94.127.67.113:8099/updateProfile") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let parametrs = ["email":self.email, "firstname": firstname, "lastname": lastname, "birthdate": birthdate, "preferences": preferences, "organization": organization, "position": position, "birth_place": birth_place, "middlename": middlename, "id": self.idUser] as [String : Any]
        guard let data = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else {return}
        
        urlRequest.httpBody = data
        
        session.dataTask(with: urlRequest) { data, response, error in
            if let response = response {
                print("response\(response)")
            }
            
            guard let data = data else {return}
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                print("jsonObject\(jsonObject)")
                
            } catch {
                let stringError = String(error.localizedDescription)
                print("error")
                viewController.showToast(message: stringError)
            }
        }.resume()
    }
}

struct User: Decodable {
    let id: String
    let email: String
    let password: String
}
