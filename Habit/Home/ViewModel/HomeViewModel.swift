//
//  HomeViewModel.swift
//  Habit
//
//  Created by coltec on 25/04/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject{
    @Published var uiState: SplashUIState = .loading
    
    func onAppear(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
        }
    }

    
}
