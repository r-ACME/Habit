//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by coltec on 02/05/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View{
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.gray, lineWidth: 0.8)
                )
    }
}
