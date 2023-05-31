//
//  SignInModel.swift
//  Habit
//
//  Created by coltec on 13/04/23.
//

import Foundation

enum SignInUIState : Equatable{
    case none
    case loading
    case goToHomeScreen
    case goToSignUp
    case error(String)
}
