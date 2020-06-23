import Foundation

// Урок 6. Домашняя работа.

//Задание 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//Задание 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов).
//Задание 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.


struct Queue<T>: CustomStringConvertible {
    private var elements: Array <T> = []
    
    mutating func enqueue(element: T) {
        elements.append(element)
    }
    mutating func dequeue() -> T? {
        guard elements.count != 0 else {
            print("Удалять больше нечего!")
            return nil
        }
        return elements.removeFirst()
    }
    
    // функция высшего порядка, фильтрующая названия цветов по наличию их в радуге
    func rainbowColorsFilter(array: [String], predicate: (String) -> Bool) -> [String] {
        var tempArray: Array<String> = []
        for element in array {
            if predicate(element) {
                tempArray.append(element)
            }
        }
        return tempArray
    }
    
    // функция высшего порядка, сортирующая названия цветов
    func sortedColors(array: [String], predicate: (String) -> Bool) -> [String] {
        var tempArray: Array<String> = []
        for element in array {
            if predicate(element) {
                tempArray.append(element)
            }
        }
        let sortedTempArray = tempArray.sorted(by: <)
        return sortedTempArray
    }
    
    // функция создания массива из элементов очереди
    func arrayCreator() -> [T] {
        return elements
    }
    
    var description: String {
        return "\(elements)"
    }
}

// описывается замыкание для фильтрации названий цветов по радуге
let rainbow: (String) -> Bool = { (color: String) -> Bool in
    // массив, содержащий названия цветов радуги, по которому осуществляется фильтрация
    let rainbowColors: Array<String> = ["red", "orange", "yellow", "green", "blue", "indigo", "purple"]
    for i in 0..<rainbowColors.count {
        if color == rainbowColors[i] {
            return true
        }
    }
    return false
}

// очередь из элементов типа String
var queueOfColors = Queue<String>()

// очередь заполняется названиями цветов
queueOfColors.enqueue(element: "black")
queueOfColors.enqueue(element: "white")
queueOfColors.enqueue(element: "gray")

// выводится очередь из названий цветов
print("Очередь из названий цветов: \(queueOfColors)")

// изымается название цвета "black"
queueOfColors.dequeue()
print("Очередь после проведенной операции по изъятию названия цвета: \(queueOfColors)")

// изымается название цвета "white"
queueOfColors.dequeue()
print("Очередь после проведенной операции по изъятию названия цвета: \(queueOfColors)")

// изымается название цвета "gray"
queueOfColors.dequeue()
print("Очередь после проведенной операции по изъятию названия цвета: \(queueOfColors)")

// срабатывает guard в функции dequeue()
queueOfColors.dequeue()
print("")

// повторное заполнение очереди из названий цветов
queueOfColors.enqueue(element: "red")
queueOfColors.enqueue(element: "brown")
queueOfColors.enqueue(element: "gray")
queueOfColors.enqueue(element: "yellow")
queueOfColors.enqueue(element: "black")
queueOfColors.enqueue(element: "indigo")
queueOfColors.enqueue(element: "white")
print("Повторно заполненная очередь из названий цветов: \(queueOfColors)")

// создание массива из элементов очереди queueOfColors
var checkedColorsArray: Array<String> = queueOfColors.arrayCreator()

// вывод на экран результата действия функции высшего порядка .rainbowColorsFilter
print("Отфильтрованные по радуге цвета: \(queueOfColors.rainbowColorsFilter(array: checkedColorsArray, predicate: rainbow))")

// вывод на экран результата действия функции высшего порядка .sortedColors
print("Отcортированные по алфавиту названия цветов: \(queueOfColors.sortedColors(array: checkedColorsArray, predicate: rainbow))")
