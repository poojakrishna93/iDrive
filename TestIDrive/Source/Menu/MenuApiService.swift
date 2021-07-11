//
//  MenuApiService.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import Foundation

class MenuApiService {
    // MARK: - Properties

    private var networkClient: NetworkClient?

    // MARK: - Initializer

    init() {
        networkClient = NetworkClient()
    }
    
    /**
     Method to demonstrate Obj-c network call
     */
    func getMenuItems(completion: @escaping NetworkCompletionHandlers.ServiceResponseObjc) {
        let networkRequest = NetworkRequest(apiEndPoint: URL(string: APIEndPoints.itemsApi), httpMethod: .get, parameters: nil)
        networkClient?.makeAPICall(Request: networkRequest, completion: { data, httpResponse, error in
            completion(data, CustomError.customMessage(message: ((error as NSError?)?.description ?? ""), code: (error as NSError?)?.code))
        })
    }
    
    /**
     Method to download image from url
     */
    func getImage(for url: String, completion: @escaping NetworkCompletionHandlers.ServiceResponseObjc) {
        guard let url = URL(string: url) else { return }
        networkClient?.downloadTask(url: url, completion: { data, httpResponse, error in
            completion(data, CustomError.customMessage(message: ((error as NSError?)?.description ?? ""), code: (error as NSError?)?.code))
        })
    }
}
