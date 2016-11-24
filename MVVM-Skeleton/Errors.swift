//
//  Errors.swift
//  MVVM-Skeleton
//
//  Created by andrei on 23/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//

import Foundation



enum MyError : Error, CustomStringConvertible {

    case serverError(message: String)

    
    public var description: String {
        switch self {
        case let .serverError(message):
            return message
        }
    }
}
