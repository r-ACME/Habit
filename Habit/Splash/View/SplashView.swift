//
//  SplashView.swift
//  Habit
//
//  Created by coltec on 11/04/23.
//

import SwiftUI

struct SplashView: View {
    
    //@State var state: SplashUIState = .loading
    //@State var state: SplashUIState = .error("Falha ao logar")
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group{
            switch viewModel.uiState{
                case .loading:
                    LoadingView()
                case .goToSignInScreen:
                    viewModel.signInView()
                case .goToHomeScreen:
                    viewModel.homeView()
                case .error(let msg):
                    loadingView(error: msg)
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

struct LoadingView: View{
    var body:some View{
        ZStack{
            Text("Loading")
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
        }
    }
}

extension SplashView{
    func loadingView(error: String? = nil) -> some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("HabitPlus"),
                              message: Text(error),
                              dismissButton:
                                .cancel(Text("Cancelar")){}
                        )
                    }
            }
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
    }
}
