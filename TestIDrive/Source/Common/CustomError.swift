//
//  CustomError.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import Foundation

enum ErrorCodeEnum: Int {
    case parseError = 500
    case networkUnavailable = -1111
    case unknown = -1002
    case databaseError = 1000
}

/// enum to hold all error codes used in the app
enum CustomError {
    case parseError
    case networkUnavailable
    case unknown
    case customMessage(message: String, code: Int?)
    case customError(error: Error)
    case databaseError
}

extension CustomError {
    public var code: ErrorCodeEnum {
        switch self {
        case .parseError:
            return ErrorCodeEnum.parseError
        case .networkUnavailable:
            return ErrorCodeEnum.networkUnavailable
        case .databaseError:
            return ErrorCodeEnum.networkUnavailable
        case let .customMessage(_, code):
            if let errorCode = code {
                return ErrorCodeEnum(rawValue: errorCode) ?? ErrorCodeEnum.unknown
            }
            return ErrorCodeEnum.unknown
        case let .customError(error):
                return ErrorCodeEnum(rawValue: error._code) ?? ErrorCodeEnum.unknown
        default:
            return ErrorCodeEnum.unknown
        }
    }

    public var localizedDescription: String {
        switch self {
        case .parseError:
            return ErrorMessageConstants.inValidData
        case .networkUnavailable:
            return ErrorMessageConstants.networkUnavailableMessage
        case .databaseError:
            return ErrorMessageConstants.dataUnavailable
        case let .customMessage(message, _):
            return message
        case let .customError(error):
            return error.localizedDescription
        default:
            return ErrorMessageConstants.unknownErrorMessage
        }
    }
}
