import UIKit

//Опционалы
/*Напишите функцию, которая принимает опциональное число ( Int?) и возвращает его квадрат, если значение присутствует, или nil в противном случае
 
 Используйте конструкцию guard или if let для безопасного извлечения опционала.
 Напишите несколько примеров вызова функции с разными входными данными (например, nil и конкретным числом).*/

func numberSquared (number: Int?) -> Int? {
    if let number {
        print (number * number)
        return number * number
    } else {
        print ("Числа не существует")
        return nil
    }
}

numberSquared(number: 5)
numberSquared(number: nil)

func numberSquared2 (number: Int?) -> Int? {
    guard let number else {
        print ("Числа не существует")
        return nil
    }
    print (number * number)
    return number * number
}

numberSquared2(number: 7)
numberSquared2(number: nil)
