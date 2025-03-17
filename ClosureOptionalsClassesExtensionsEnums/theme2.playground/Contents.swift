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
    return filterdArray
}

print(filter(array: [1, 2, 3, 4, 5, 6]) { $0 % 2 == 0
})


//Классы и Наследование
/*Создайте базовый класс Animal с такими свойствами, как name (имя животного), и методом speak(), который выводит строку с типичным звуком животного
 
 Создайте два подкласса: Dog и Cat , которые наследуются от Animal .
 Переопределите метод speak() в каждом подклассе так, чтобы собака лаяла (например,"Гав!"), а кошка мяукала (например,"Мяу!").
 Создайте объекты каждого типа и продемонстрируйте их поведение.*/

class Animal {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func speak() -> String {
        return "Animal speak"
    }
}

class Dog: Animal {
    override func speak() -> String {
        print ("Гав!")
        return "Гав!"
    }
}
class Cat: Animal {
    override func speak() -> String {
        print ("Мяу!")
        return "Мяу!"
    }
}

let dog = Dog(name: "Рэкс")
dog.speak()

let cat = Cat(name: "Барсик")
cat.speak()


//Протоколы и Расширения
/*Определите протокол Identifiable, требующий наличие свойства id типа String.
 
 Создайте расширение для протокола Identifiable, которое добавляет метод printId(), выводящий значение id в консоль.
 Реализуйте структуру (например, User или Product), которая соответствует протоколу Identifiable, и протестируйте работу метода из расширения*/

protocol Identifiable {
    var id: String { get set}
}

extension Identifiable {
    func printId() {
        print("Значение id пользователя:\(id)")
    }
}

struct User: Identifiable {
    var id: String
}

struct Product: Identifiable {
    var id: String
}

var user = User(id: "123")
user.printId()

var product = Product(id: "456")
product.printId()
