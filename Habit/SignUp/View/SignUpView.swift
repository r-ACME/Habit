//
//  SignUpView.swift
//  Habit
//
//  Created by coltec on 25/04/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        
        Group{
            switch viewModel.uiState{
            case .none:
                NavigationView{
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                fullNameInput
                            }
                            HStack{
                                Text("Genero: ")
                                genderView
                            }
                            HStack{
                                emailInput
                            }
                            HStack{
                                passwordInput
                            }
                            HStack{
                                documentInput
                            }
                            HStack{
                                phoneInput
                            }
                            HStack{
                                birthdayInput
                            }
                            HStack{
                                buttonSignUp
                            }
                        }
                    }.padding(.top, 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 32)
                        .background(Color.white)
                        .navigationBarTitle("SignUp", displayMode: .inline)
                }
                
            case .loading:
                Text("Loading...")
            case .success:
                viewModel.signUpFinish()
            case .error(let msg):
                loadingView(error: msg)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
}

extension SignUpView{
    var fullNameInput: some View{
        EditTextView( placeholder: "Informe nome completo",
                      text: $viewModel.fullName,
                      error: "Nome precisa ter pelo menos 3 caracteres",
                      failure: viewModel.fullName.count < 3,
                      keyboard: .alphabet)
    }
}

extension SignUpView{
    var emailInput: some View{
        EditTextView( placeholder: "Informe seu e-mail",
                      text: $viewModel.email,
                      error: "E-mail invalido",
                      failure: !viewModel.email.isEmail(),
                      keyboard: .emailAddress)
    }
}

extension SignUpView{
    var passwordInput: some View{
        EditTextView( placeholder: "Preencha sua senha",
                      text: $viewModel.password,
                      error: "Senha precisa ter pelo menos 8 caracteres",
                      failure: viewModel.password.count < 8,
                      keyboard: .emailAddress,
                      isSecure: true)
    }
}

extension SignUpView{
    var documentInput: some View{
        EditTextView( placeholder: "Informe seu CPF (apenas numeros)",
                      text: $viewModel.document,
                      error: "CPF Invalido",
                      failure: viewModel.document.count != 11,
                      keyboard: .numberPad)
    }
}

extension SignUpView{
    var phoneInput: some View{
        EditTextView( placeholder: "Informe seu telefone de contato",
                      text: $viewModel.phone,
                      error: "Telefone de contato precisa de DDD + 8 ou 9 digitos",
                      failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12,
                      keyboard: .numberPad)
    }
}

extension SignUpView{
    var birthdayInput: some View{
        EditTextView( placeholder: "Informe sua data de nascimento",
                      text: $viewModel.birthday,
                      error: "Formato DD/MM/AAAA",
                      failure: !viewModel.isDateValid(),
                      keyboard: .default)
    }
}

extension SignUpView{
    var buttonSignUp: some View{
        LoadingButtonView(action: {viewModel.signup()},
                          text: "Realize seu cadastro",
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 8 ||
                          viewModel.fullName.count < 3 || viewModel.document.count != 11 ||
                          viewModel.phone.count < 10 || viewModel.phone.count >= 12 ||
                          !viewModel.isDateValid(),
                          showProgress: self.viewModel.uiState == SignUpUIState.loading)
    }
}

extension SignUpView{
    var genderView: some View{
        Picker("Genero", selection: $viewModel.gender){
            ForEach(Gender.allCases, id: \.self){
                value in
                Text(value.rawValue).tag(value)
            }
        }
    }
}

extension SignUpView{
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
