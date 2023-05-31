//
//  SplashViewModel.swift
//  Habit
//
//  Created by Raphael on 11/04/23.
//

import Foundation
import SwiftUI
import Combine

class SplashViewModel: ObservableObject{
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear(){
        
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(3), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink{ userAuth in
                
                if userAuth == nil{
                    self.uiState = .goToSignInScreen
                }
                else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)){
                    
                    self.cancellableRefresh = self.interactor.refreshToken(request:
                                                    RefreshRequest(token: userAuth!.refreshToken))
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch completion{
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                tokenType: success.tokenType)
                            self.interactor.insertUserAuth(userAuth: auth)
                            self.uiState = .goToHomeScreen
                        }
                        )
                }
                else{
                    self.uiState = .goToHomeScreen
                }
            }
    }
    
    func signInView() -> some View{
        return SplashViewRouter.makeSignInView()
    }
    
    func homeView() -> some View{
        return SplashViewRouter.makeHomeView()
    }
}
