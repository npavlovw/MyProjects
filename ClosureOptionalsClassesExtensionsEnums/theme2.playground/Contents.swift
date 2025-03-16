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



//Замыкания
/* Создайте функцию, которая принимает массив чисел ( [Int]) и замыкание, которое проверяет, удовлетворяет ли элемент заданному условию (тип замыкания: (Int) -> Bool ). Функция должна вернуть новый массив, состоящий только из тех элементов, для которых замыкание возвращает true.
 
 Реализуйте логику фильтрации внутри функции, не используя стандартный метод filter
 Продемонстрируйте работу функции, передав в качестве замыкания условие для выбора чётных чисел.*/

func filter (array: [Int], condition: ((Int) -> Bool)?) -> [Int] {
    guard let condition else {
        print ("Условия не задано")
        return []
    }
    var filterdArray: [Int] = []
    for i in array {
        if condition(i) {
            filterdArray.append(i)
        }
    }
    print (filterdArray)
    return filterdArray
}

filter(array: [1, 2, 3, 4, 5, 6]) { i in
    i % 2 == 0
}
