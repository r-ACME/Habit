//
//  HabitApp.swift
//  Habit
//
//  Created by Raphael on 11/04/23.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
