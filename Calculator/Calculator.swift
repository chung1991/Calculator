//
//  Calculator.swift
//  Calculator
//
//  Created by Chung Nguyen on 6/7/22.
//

import Foundation

enum CalculatorError: Error {
    case divByZero
}

class Calculator {
    static let shared = Calculator()
    let operators: Set<Character> = ["+", "-", "X", ":"]
    
    func calculate(_ s: String) throws -> String {
        let chars = Array(s)
        var result = 0.0
        var prevVal = 0.0
        var sign: Character = "+" // store the last sign of prev val
        var index = 0
        
        // case 32X => return ""
        if let lastChar = chars.last, operators.contains(lastChar) {
            return ""
        }
        
        //  34+3-7/2/6/8/9+5+2+
        //  34: prevVal 3
        //  37: prevVal -7
        //  37: prevVal -7/2/6/8/9
        while index < chars.count {
            let char = chars[index]
            // if char is operator, save the operator
            if operators.contains(char) {
                sign = char
            } else {
                // form a number from consecutive digits
                var curVal = Int("\(char)")!
                var foundDec = false
                var curDec: [Character] = []
                while index < chars.count - 1, !operators.contains(chars[index+1]) {
                    if chars[index+1] == "." {
                        foundDec = true
                        index += 1
                        continue
                    }
                    if !foundDec {
                        let digit = Int("\(chars[index+1])")!
                        curVal = curVal * 10 + digit
                    } else {
                        curDec.append(chars[index+1])
                    }
                    index += 1
                }
                let dec = curDec.count == 0 ? "0" : String(curDec.prefix(2))
                let curDoubleVal = Double("\(curVal).\(dec)")!
                
                switch sign {
                case "+":
                    result += prevVal
                    prevVal = curDoubleVal
                case "-":
                    result += prevVal
                    prevVal = -curDoubleVal
                case "X":
                    prevVal *= curDoubleVal
                default:
                    if curVal == 0 { throw CalculatorError.divByZero }
                    prevVal /= curDoubleVal
                }
            }
            index += 1
        }
        result += prevVal
        
        var num = String(format:"%.02f", result)
        if num.suffix(2) == "00" {
            num.removeLast()
            num.removeLast()
            num.removeLast()
        }
        return num
    }
}
