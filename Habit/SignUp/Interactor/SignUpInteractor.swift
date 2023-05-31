//
//  SignUpInteractor.swift
//  Habit
//
//  Created by coltec on 30/05/23.
//

import Foundation

import Foundation
import Combine

class SignUpInteractor{
    
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let local: LocalDataSource = .shared

    func postUser(request: SignUpRequest) -> Future<Bool, AppError>{
        return remoteSignUp.postUser(request: request)
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError>{
        return remoteSignIn.login(request: request)
    }
    
    func insertUserAuth(userAuth : UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
}
