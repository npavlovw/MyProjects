import UIKit

class Book {
    var title: String
    var author: String
    var year: Int
    var isAvailable: Bool
    
    init(title: String, author: String, year: Int, isAvailable: Bool = true) {
        self.title = title
        self.author = author
        self.year = year
        self.isAvailable = isAvailable
    }
    
    func getDescription() {
        print("Книга \(title) автора \(author) \(year) года написания \(isAvailable ? "доступна" : "отсутствует")")
    }
}

class User {
    var name: String
    var borrowedBooks: [String]
    
    init(name: String, borrowedBooks: [String] = []) {
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
    
    func borrowBook(book: Book) {
        guard book.isAvailable else {
            print("Книги нет в наличии")
            return
        }
        borrowedBooks.append(book.title)
        book.isAvailable = false
        print("\(name) взял книгу \(book.title)")
    }
    
    func returnBook(book: Book) {
        guard let index = borrowedBooks.firstIndex(of: book.title) else {
            print("Книги \(book.title) нет у пользователя \(name)")
            return
        }
        borrowedBooks.remove(at: index)
        book.isAvailable = true
        print("Пользователь \(name) вернул книгу \(book.title)")
    }
}

class Librarian {
    func findBook(byTitle title: String, in books: [Book]) -> Book? {
        return books.first { $0.title == title }
    }
    
    func listAvailableBooks(books: [Book]) {
        var availableBooks = books.filter({ $0.isAvailable })
        if availableBooks.isEmpty {
            print("В библиотеке нет свободных книг")
        } else {
            
            print("В наличии есть книги:")
            for book in availableBooks {
                print(book.getDescription())
            }
        }
    }
}

//масив книг
var book1: Book = Book(title: "1984", author: "George Orwell", year: 1949)
var book2: Book = Book(title: "To Kill a Mockingbird", author: "Harper Lee", year: 1960)
var book3: Book = Book(title: "War and piece", author: "Lev Tolstoy", year: 1863)
var book4: Book = Book(title: "Swift", author: "Vasiliy Usov", year: 2022)
var book5: Book = Book(title: "Crime and punishment", author: "Fyodor Dostoevsky", year: 1865)

var books = [book1, book2, book3, book4, book5]

//пользователи
let user1: User = User(name: "John")
let user2: User = User(name: "Alex")
let user3: User = User(name: "Dima")

//библиотекарь

let librarian = Librarian()

librarian.listAvailableBooks(books: books)


user1.borrowBook(book: book1)
user2.borrowBook(book: book3)
user3.borrowBook(book: book5)

librarian.listAvailableBooks(books: books)

user2.returnBook(book: book3)

librarian.listAvailableBooks(books: books)
