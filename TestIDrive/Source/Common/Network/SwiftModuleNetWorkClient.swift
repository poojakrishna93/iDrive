//
//  SwiftModuleNetWorkClient.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import Foundation

class NetworkClient {

    // MARK: - Properties

    // MARK: - Initializer

    init() {

    }

    // MARK: - Custom Accessors

    /**
     Method to make API request with out session configurations
     */
    func makeAPICall(Request request: NetworkRequest, completion:@escaping(Data?, HTTPURLResponse?, Error?)->Swift.Void) {

        guard let api = request.apiEndPoint, let method = request.httpMethod else {
            return
        }

        var dataRequest = URLRequest(url: api)
        dataRequest.httpMethod = method.rawValue

        if let parameters = request.parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            dataRequest.httpBody = jsonData
        }

        let task = URLSession.shared.dataTask(with: dataRequest) {(data, response, error) in

            completion(data, response as? HTTPURLResponse, error)
        }

        task.resume()
    }

    /**
     Method to download
     */
    func downloadTask(url: URL, completion:@escaping(Data?, HTTPURLResponse?, Error?)->Swift.Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            completion(data, response as? HTTPURLResponse, error)
        }
        task.resume()
    }
   
}
