//
//  NetworkConstants.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

/**
This class has all the networkClient related constants
*/
import UIKit

/**
 Struct that holds required parameters for the network call.
 */
public struct NetworkRequest {
    let apiEndPoint: URL?
    let httpMethod: HTTPMethod?
    let parameters: [String: Any]?
}

/**
 enum that holds all the https method types
 */
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case delete  = "DELETE"
}

/**
 Common completion handlers used in network calls
 */
struct NetworkCompletionHandlers {
    typealias ServiceResponse = (Data?, CustomError?) -> Swift.Void
    typealias ServiceResponseObjc = (Any?, CustomError?) -> Swift.Void
    typealias ErrorResponse = (CustomError?) -> Swift.Void
    typealias ImageResponse = (UIImage?) -> Swift.Void
}

struct APIEndPoints {
    static let itemsApi = "https://60d2fa72858b410017b2ea05.mockapi.io/api/v1/menu"
}


