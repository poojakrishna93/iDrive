//
//  JSONParser.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import Foundation

/**
 Class responsible to decode data into codable protocol conforming class/struct/enum
 */
class JSONParser {
    // MARK: - Properties

    typealias ResultBlock<T> = (Result<T, Error>) -> Void

    // MARK: - Initializer

    init() {}

    // MARK: - Public Accessors

    /**
     Method to parse json data to corresponding data type
     @param `jsonData` - expecting result from api in `Data` type
     @param `type` - type to which data should be decoded this can be `Codable` conformed `struct\enum\class`
     */
    public func parseJsonData<T: Decodable>(dataFromAPI: Any?, type: T.Type, completion: @escaping ResultBlock<T>) {
        let error = NSError(domain: "app.com", code: 500, userInfo: [NSLocalizedDescriptionKey: "", NSLocalizedFailureReasonErrorKey: ""])

        /// Validating data received from API
        guard let validateddataFromAPI: Any = dataFromAPI else {
            return completion(.failure(error))
        }

        var jsonData: Data?
        validateDataFromAPI(validateddataFromAPI, &jsonData)

        /**
         Decision making point to check validity of decodable data
         */
        guard let decodableData = jsonData else {
            return completion(.failure(error))
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: decodableData)
            completion(.success(decodedData))

        } catch {
            completion(.failure(error))
        }
    }
}

// MARK: - Private Accessors

private extension JSONParser {
    /**
     Method to validate data received from server
      @param `dataFromAPI` - data recived from server
      @param `jsonData` - data to decode
     */
    func validateDataFromAPI(_ dataFromAPI: Any, _ jsonData: inout Data?) {
        // ----Validating response received from server is of type `Data` else will serialize the response received from server to type `Data`
        if let validData: Data = dataFromAPI as? Data {
            jsonData = validData
        } else {
            /// Json object validation of server response
            guard JSONSerialization.isValidJSONObject(dataFromAPI) else {
                print("response is not a valid json object")
                return
            }
            if let validData = try? JSONSerialization.data(withJSONObject: dataFromAPI as Any, options: JSONSerialization.WritingOptions.prettyPrinted) {
                jsonData = validData
            }
        }
    }
}
