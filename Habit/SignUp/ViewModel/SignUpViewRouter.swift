//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by coltec on 25/04/23.
//

import Foundation
import SwiftUI


enum SignUpViewRouter{
    
    static func makeSignInView() -> some View{
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
    
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
