//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by coltec on 30/05/23.
//

import Foundation
import Combine

class SignUpRemoteDataSource{
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init(){
        
    }
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError>{
        
        return Future{ promise in
            WebService.call(path: .postUser, body: request){ result in
                switch result {
                    case .success(let data):
                        if let data = data {
                            promise(.success(true))
                        }
                        break
                    case .failure(let error, let data):
                        if let data = data{
                            if error == .badRequest{
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(ErrorResponse.self, from: data)
                                
                                promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor")))
                            }
                        }
                        break
                }
            }
        }
    }
    
}
