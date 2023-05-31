//
//  SplashInteractor.swift
//  Habit
//
//  Created by coltec on 30/05/23.
//

import Foundation
import Combine

class SplashInteractor{
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetchAuth() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError>{
        return remote.refreshToken(request: request)
    }
    
    func insertUserAuth(userAuth: UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
}
