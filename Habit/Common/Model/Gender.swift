//
//  Gender.swift
//  Habit
//
//  Created by coltec on 27/04/23.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable{
    case female = "Fem"
    case male = "Masc"
    case other = "NB"
    case notInformed = "Nao informar"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{ self == $0} ?? 0
    }
}
