//
//  main.swift
//  MyCalculator
//
//  Created by Никита Павлов on 21.03.2025.
//

import Foundation

//NumberOne
var doubleNumberOne: Double? = nil
print("Введите первое число")
while doubleNumberOne == nil {
    let numberOne = readLine() ?? ""
    if let numberOne = Double(numberOne) {
        doubleNumberOne = numberOne
        } else {
        print("Неверный формат данных, введите число")
    }
}


//Operation
var operation: String = ""
print("Введите операцию")
while operation == "" {
    operation = readLine() ?? ""
    if operation == "" {
        print("Отсутствует знак! Введите знак!")
    } else if operation != "+" && operation != "-" && operation != "*" && operation != "/" && operation != "%" && operation != "^" {
        operation = ""
        print("Неверный знак! Введите знак!")
    }
}
    

//NumberTwo
var doubleNumberTwo: Double? = nil
print("Введите второе число")
while doubleNumberTwo == nil {
    let numberTwo = readLine() ?? ""
    if let numberTwo = Double(numberTwo) {
        doubleNumberTwo = numberTwo
        } else {
        print("Неверный формат данных, введите число")
    }
}

//Calculation
switch operation {
case "+":
    print(doubleNumberOne! + doubleNumberTwo!)
case "-":
    print(doubleNumberOne! - doubleNumberTwo!)
case "*":
    print(doubleNumberOne! * doubleNumberTwo!)
case "/":
    if doubleNumberTwo! == 0 {
        print("Деление на ноль невозможно!")
    } else {
        print(doubleNumberOne! / doubleNumberTwo!)
    }
case "%":
    print(doubleNumberOne!.truncatingRemainder(dividingBy: doubleNumberTwo!))
case "^":
    print(pow(doubleNumberOne!, doubleNumberTwo!))
default:
    print("Неверная операция")
}



/* Забил свой код в GPT и попросил исправить. Итог внизу. Есть над чем работать!*/

//import Foundation
//
///// Функция для безопасного ввода числа
//func getDoubleInput(prompt: String) -> Double {
//    var number: Double? = nil
//    while number == nil {
//        print(prompt)
//        if let input = readLine(), let value = Double(input) {
//            number = value
//        } else {
//            print("Ошибка! Введите корректное число.")
//        }
//    }
//    return number!
//}
//
///// Функция для ввода операции
//func getOperationInput() -> String {
//    let validOperations = ["+", "-", "*", "/", "%", "^"]
//    var operation: String = ""
//
//    while operation.isEmpty {
//        print("Введите операцию (+, -, *, /, %, ^):")
//        if let input = readLine(), validOperations.contains(input) {
//            operation = input
//        } else {
//            print("Ошибка! Введите один из допустимых знаков: +, -, *, /, %, ^")
//        }
//    }
//    return operation
//}
//
//// Ввод данных
//let numberOne = getDoubleInput(prompt: "Введите первое число:")
//let operation = getOperationInput()
//let numberTwo = getDoubleInput(prompt: "Введите второе число:")
//
//// Выполнение вычислений
//switch operation {
//case "+":
//    print("Результат: \(numberOne + numberTwo)")
//case "-":
//    print("Результат: \(numberOne - numberTwo)")
//case "*":
//    print("Результат: \(numberOne * numberTwo)")
//case "/":
//    if numberTwo == 0 {
//        print("Ошибка: Деление на ноль невозможно!")
//    } else {
//        print("Результат: \(numberOne / numberTwo)")
//    }
//case "%":
//    print("Результат: \(numberOne.truncatingRemainder(dividingBy: numberTwo))")
//case "^":
//    print("Результат: \(pow(numberOne, numberTwo))")
//default:
//    print("Ошибка: неизвестная операция")
//}
