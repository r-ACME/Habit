//
//  ErrorResponse.swift
//  Habit
//
//  Created by coltec on 23/05/23.
//

import Foundation

struct ErrorResponse: Decodable{
    
    let detail: String
    
    enum CodingKeys: String, CodingKey{
        case detail
    }
    
}

enum AppError: Error{
    case response(message: String)
    
    public var message: String{
        switch self{
        case .response(let message):
            return message
        }
    }
}
