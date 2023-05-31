//
//  SignInView.swift
//  Habit
//
//  Created by coltec on 13/04/23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action: Int? = 0
    @State var navigationBarHidden = true
    
    var body: some View {
        
        Group{
            switch viewModel.uiState{
            case .none,
             .loading:
                NavigationView{
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .center, spacing: 8){
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 100)
                                .padding(20)
                                .background(Color.white)
                                .ignoresSafeArea()
                            HStack{
                                Text("Login: ")
                                emailView
                            }
                            HStack{
                                Text("Senha: ")
                                passwordView
                            }
                            HStack{
                                buttonEnterView
                            }
                            HStack{
                                Text("Ainda não possuo cadastro")
                                    .foregroundColor(Color.gray)
                                    .padding(.top, 100)
                            }
                            HStack{
                                buttonCreateAccountView
                            }
                        }
                    }.padding(.top, 120)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 32)
                        .background(Color.white)
                        .navigationBarTitle("Login", displayMode: .inline)
                        .navigationBarHidden(navigationBarHidden)
                }
            /*
                Text("Loading...")*/
            case .goToHomeScreen:
                viewModel.homeView()
            case .goToSignUp:
                viewModel.signUpView()
            case .error(let msg):
                loadingView(error: msg)
            }
        }
        
        
    }
}

extension SignInView{
    var emailView: some View{
//        TextField("example@email.com", text: $email)
//            .border(.clear)
//            .textFieldStyle(.roundedBorder)
        EditTextView(placeholder: "E-mail",
                     text: $viewModel.email,
                     error: "E-mail invalido",
                     failure: !viewModel.email.isEmail(),
                     keyboard: .emailAddress,
                     isSecure: false)
    }
}

extension SignInView{
    var passwordView: some View{
        EditTextView(placeholder: "Senha",
                     text: $viewModel.password,
                     error: "Senha Invalida",
                     failure: !viewModel.password.isPassword(),
                     keyboard: .emailAddress,
                     isSecure: true)
    }
}

extension SignInView{
    var buttonEnterView: some View{
        
        LoadingButtonView(action: {viewModel.login()},
                          text: "Entrar",
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 8,
                          showProgress: self.viewModel.uiState == SignInUIState.loading)
    }
}

extension SignInView{
    var buttonCreateAccountView: some View{
        ZStack{
            NavigationLink(destination: viewModel.signUpView(), tag: 1, selection: $action, label: {EmptyView()})
                Button("Criar uma conta"){
                    self.action = 1
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel(interactor: SignInInteractor()))
    }
}


extension SignInView{
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
                                .cancel(Text("Cancelar")){viewModel.errorFix()}
                        )
                    };
            }
            
            
        }
    }
}
