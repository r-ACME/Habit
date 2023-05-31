//
//  EditTextView.swift
//  Habit
//
//  Created by coltec on 02/05/23.
//

import Foundation
import SwiftUI

struct EditTextView: View{
    
    var placeholder: String = ""
    @Binding var text: String
    
    var error: String? = nil
    var failure: Bool? = nil
    
    var keyboard: UIKeyboardType = .default
    
    var isSecure: Bool = false
    
    var body: some View{
        VStack{
            if isSecure{
                SecureField(placeholder, text: $text)
                    .border(.clear)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocapitalization(.none)
                if let error = error, failure == true, !text.isEmpty{
                    Text(error).foregroundColor(.red)
                }
            }
            else{
                TextField(placeholder, text: $text)
                        .border(.clear)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(keyboard)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocapitalization(.none)
                if let error = error, failure == true, !text.isEmpty{
                    Text(error).foregroundColor(.red)
                }
            }
        }
        .padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self){ value in
            EditTextView(placeholder: "", text: .constant(""), keyboard: .default)
                .preferredColorScheme(value)
        }
    }
}
