import UIKit

let names = ["Anna", "Max", "Tom", "Elena"]

// TODO: Отсортируй по убыванию
let sortedNames = names.sorted { (a, b) in
    b > a
}

print(sortedNames)
