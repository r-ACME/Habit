//
//  SplashViewRouter.swift
//  Habit
//
//  Created by coltec on 13/04/23.
//

import Foundation
import SwiftUI


enum SplashViewRouter{
    
    static func makeSignInView() -> some View{
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
    
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
