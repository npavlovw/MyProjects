import UIKit

enum AnimalType {
    case mammal
    case bird
    case reptile
    case fish
}

class Animal {
    
    var name: String
    var type: AnimalType
    var age: Int
    
    init(name: String, type: AnimalType, age: Int) {
        self.name = name
        self.type = type
        self.age = age
    }
    
    func makeSound() -> String {
        return ""
    }
}

class Mammal: Animal {
    var furColor: String
    
    init(name: String, type: AnimalType, age: Int, furColor: String) {
        self.furColor = furColor
        super.init(name: name, type: type, age: age)
    }
    
    override func makeSound() -> String {
        "Лев рычит: рррррр"
    }
}

class Bird: Animal {
    var canFly: Bool
    
    init(name: String, type: AnimalType, age: Int, canFly: Bool) {
        self.canFly = canFly
        super.init(name: name, type: type, age: age)
    }
    
    override func makeSound() -> String {
        "Попугай говорит: чирик-чирик"
    }
}

class Reptile: Animal {
    var isVenomous: Bool
    
    init(name: String, type: AnimalType, age: Int, isVenomous: Bool) {
        self.isVenomous = isVenomous
        super.init(name: name, type: type, age: age)
    }
    
    override func makeSound() -> String {
        "Змея шипит: шшшш"
    }
}

protocol Feedable {
    func feed()
}

extension Feedable {
    func feed() -> String {
        "Животное покормлено"
    }
}

class Zookeeper: Feedable {
    func feed() {
        "Животное покормлено"
    }
}

let mammal = Mammal(name: "Lion", type: .mammal, age: 4, furColor: "Orange")
let bird = Bird(name: "Kesha", type: .bird, age: 2, canFly: true)
let reptile = Reptile(name: "Snake", type: .reptile, age: 3, isVenomous: true)

let animals = [mammal, bird, reptile]
for animal in animals {
    print(animal.makeSound())
}
