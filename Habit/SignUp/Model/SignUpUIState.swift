//
//  SignUpUIState.swift
//  Habit
//
//  Created by coltec on 25/04/23.
//

import Foundation

enum SignUpUIState : Equatable{
    case none
    case loading
    case success
    case error(String)
}
