//
//  SignUpViewModel.swift
//  Habit
//
//  Created by coltec on 25/04/23.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel : ObservableObject{
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    private var cancellableRequestSignIn: AnyCancellable?
    private var cancellableRequestSignUp: AnyCancellable?
    
    private let interactor: SignUpInteractor
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    @Published var uiState: SignUpUIState = .none
    
    init(interactor: SignUpInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableRequestSignIn?.cancel()
        cancellableRequestSignUp?.cancel()
    }
    func login( email: String, password: String){
        
        self.uiState = .loading  //para barra de progresso e carregamento
        
        
        
    }
    
    func errorFix () {
        
        self.uiState = .none
    }
    
    func signInView() -> some View{
        return SignUpViewRouter.makeSignInView()
    }
    
    func isDateValid() -> Bool{
        
        if(birthday.count == 10){
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "dd/MM/yyyy"
            
            guard formatter.date(from: birthday) != nil else{
                return false
            }
            return true
        }
        return false
    }
    
    func signup(){
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        guard let dateFormatted = formatter.date(from: birthday) else{
            self.uiState = .error("Data invalida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        birthday = formatter.string(from: dateFormatted)
        
        self.cancellableRequestSignUp = self.interactor.postUser(request: SignUpRequest(fullName: fullName,
                         email: email,
                         password: password,
                         document: document,
                         phone: phone,
                         birthday: birthday,
                        gender: gender.index))
        .receive(on: DispatchQueue.main)
        .sink{ completion in
            
            switch(completion){
            case .failure(let appError):
                self.uiState = .error(appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { created in
            if (created){
                self.cancellableRequestSignIn = self.interactor.login(request:
                                                                    SignInRequest(email: self.email,
                                                                               password: self.password))
                .receive(on: DispatchQueue.main)
                .sink{ completion in
                    
                    switch(completion){
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { success in
                    print(success)
                    
                    let auth = UserAuth(idToken: success.accessToken,
                                        refreshToken: success.refreshToken,
                                        expires: Date().timeIntervalSince1970 + Double(success.expires),
                                        tokenType: success.tokenType)
                    self.interactor.insertUserAuth(userAuth: auth)
                    self.publisher.send(created)
                    self.uiState = .success
                }
            }
        }
    }
    
    func signUpFinish() -> some View{
        
        homeView()
    }
    
    func homeView() -> some View{
        return SignUpViewRouter.makeHomeView()
    }
    
}
