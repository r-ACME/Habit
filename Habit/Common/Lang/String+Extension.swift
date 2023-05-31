//
//  String+Extension.swift
//  Habit
//
//  Created by coltec on 02/05/23.
//

import Foundation


extension String{
    func isEmail() -> Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,10}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func isPassword() -> Bool{
        let regEx = "[A-Z0-9a-z]{6,16}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
}
