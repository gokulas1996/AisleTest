//
//  NetworkManager.swift
//  Aisle
//
//  Created by Gokul A S on 24/09/22.
//

import Foundation

class NetworkManager: NSObject, URLSessionDelegate {
    
    static let shared = NetworkManager()
    
    private override init() {}
    
    enum HttpMethod: String {
        case get
        case post
        
        var method: String { rawValue.uppercased() }
    }
    
    enum Status {
        case success
        case error
    }
    
    // Network manager function to fetch data from url
    func fetchData(endPoint: String, headers: [String: String]?, parameters: [String: String]?, httpMethod: HttpMethod, completionHandler : @escaping (_ data: Data?, _ status: Status?, _ error: Error?) -> Void) {
        guard let url = URL(string:"\(Constants.baseURL)\(endPoint)") else{ return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = httpMethod.method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if let parameters = parameters {
            let body = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = body
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral,
                                         delegate: self,
                                         delegateQueue: nil)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                completionHandler(data, .success, nil)
            } else if let error = error {
                print(error.localizedDescription)
                completionHandler(nil, .error, error)
            }
        }
        task.resume()
    }
    
    public func dataToJSON(data: Data) -> Any? {
       do {
           return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
       } catch let myJSONError {
           print(myJSONError)
       }
       return nil
    }
    
}

extension NetworkManager {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
        }
        return completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
    }
}
