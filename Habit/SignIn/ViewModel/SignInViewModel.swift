//
//  SignInViewModel.swift
//  Habit
//
//  Created by coltec on 13/04/23.
//

import Foundation
import SwiftUI
import Combine

class SignInViewModel : ObservableObject{
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    @Published var email = ""
    @Published var password = ""
    
    init(interactor: SignInInteractor){
        self.interactor = interactor
        cancellable = publisher.sink{ value in
            if(value){
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    func login(){
        
        self.uiState = .loading  //para barra de progresso e carregamento
        
        cancellableRequest = interactor.login(request: SignInRequest(email: email,
                                                password: password))
        .receive(on: DispatchQueue.main)
        .sink{ completion in
            
            switch(completion){
            case .failure(let appError):
                self.uiState = SignInUIState.error(appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { success in
            self.interactor.insertAuth(userAuth: UserAuth(idToken: success.accessToken,
                                                          refreshToken: success.refreshToken,
                                                          expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                          tokenType: success.tokenType))
            self.uiState = .goToHomeScreen
        }
    }
    
    func errorFix () {
        
        self.uiState = .none
    }
    
    func homeView() -> some View{
        return SignInViewRouter.makeHomeView()
    }
    
    func signUp(){
        self.uiState = .goToSignUp
    }
    
    func signUpView() -> some View{
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
    
    deinit{
        cancellable?.cancel()
    }
}
