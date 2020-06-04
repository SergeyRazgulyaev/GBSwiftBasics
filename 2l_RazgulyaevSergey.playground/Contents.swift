import Foundation

// Урок 2. Домашняя работа.


// Задание 1. Написать функцию, которая определяет, четное число или нет.
print("Задание 1. Написать функцию, которая определяет, четное число или нет.")
print("Начальные условия: Пусть задается случайное число от 1 до 100.")
print("Решение:")

// Функция evenOrOddNumber определяет четным или нечетным является число
func evenOrOddNumber (checkedNumber: Int) {
    if checkedNumber.isMultiple(of: 2) {
        return print("Число \(checkedNumber) является четным.")
    } else {
        return print("Число \(checkedNumber) является нечетным.")
    }
}
let randomNumber1: Int = Int.random(in: 1...100) // Задается случайное число
print("Получено случайное число: \(randomNumber1).")
evenOrOddNumber(checkedNumber: randomNumber1)
print("------------------------------------------------\n")


// Задание 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
print("Задание 2. Написать функцию, которая определяет, делится ли число без остатка на 3.")
print("Начальные условия: Пусть задается случайное число от 1 до 100.")
print("Решение:")
// Функция divisionByThree определяет делится ли число без остатка на 3
func divisionByThree (checkedNumber: Int) {
    if checkedNumber.isMultiple(of: 3) {
        return print("Число \(checkedNumber) делится на 3 без остатка.")
    } else {
        return print("Число \(checkedNumber) не делится на 3 без остатка.")
    }
}
let randomNumber2: Int = Int.random(in: 1...100) // Задается случайное число
print("Получено случайное число: \(randomNumber2).")
divisionByThree(checkedNumber: randomNumber2)
print("------------------------------------------------\n")



//Альтернативный вариант решения Заданий 1 и 2:
print("Альтернативный вариант решения Заданий 1 и 2.")
print("Написать функцию, которая определяет: четное число или нет; делится ли число без остатка на 3.")
print("Начальные условия: Пусть задается случайное число от 1 до 100.")
print("Решение:")

// Создаем функцию, которой в качестве второго аргумента пользователем передается делитель (divider):
// 2 - для проверки четности/нечетности числа;
// 3 - для проверки деления числа на три без остатка.
func divisionByTwoAndThree (checkedNumber: Int, divider: Int) {
    switch divider {
    case 2: // В данном случае находится остаток от деления на 2 (не используется checkedNumber.isMultiple(of: 2)) только для того, чтобы показать возможность данного (классического) способа записи.
        if checkedNumber%2 == 0 {
            return print("Число \(checkedNumber) является четным.")
        } else {
            return print("Число \(checkedNumber) является нечетным.")
        }
    case 3: // В данном случае находится остаток от деления на 3 (не используется checkedNumber.isMultiple(of: 3)) только для того, чтобы показать возможность данного (классического) способа записи
        if checkedNumber%3 == 0 {
            return print("Число \(checkedNumber) делится на 3 без остатка.")
        } else {
            return print("Число \(checkedNumber) не делится на 3 без остатка.")
        }
    default:
        // Если пользователь задал значение делителя отличное от 2 или 3, то выдается следующее предупреждение
        print("Данная функция осуществляет проверку на деление числа только на 2 и 3")
    }
}
let randomNumber3: Int = Int.random(in: 1...100) // Задается случайное число
print("Получено случайное число: \(randomNumber3).")

divisionByTwoAndThree(checkedNumber: randomNumber3, divider: 2)
divisionByTwoAndThree(checkedNumber: randomNumber3, divider: 3)
print("------------------------------------------------\n")


// Задание 3. Создать возрастающий массив из 100 чисел.
print("Задание 3. Создать возрастающий массив из 100 чисел.")
print("Начальные условия: Отсутствуют.")
print("Решение:")

// Самый простой способ
let array100 = Array(1...100)

// Более сложный способ
var array100Alternative: Array <Int> = []
for i in 1...100 {
    array100Alternative.append(i)
}
print(array100Alternative)
print("------------------------------------------------\n")


// Задание 4. Удалить из массива, полученного в Задании 3 все четные числа и все числа, которые не делятся на 3.
print("Задание 4. Удалить из массива, полученного в Задании 3 все четные числа и все числа, которые не делятся на 3.")
print("Начальные условия: Массив из Задания 3")
print("Решение:")

// Функция проверки числа на нечетность (true - нечетное, false - четное)
func oddNumber (checkedNumber: Int) -> Bool {
    if checkedNumber.isMultiple(of: 2) {
        return false
    } else {
        return true
    }
}
// Функция проверки числа на кратность 3-м (true - кратное 3-м, false - не кратное 3-м)
func divisibleByThreeNumber (checkedNumber: Int) -> Bool {
    if checkedNumber.isMultiple(of: 3) {
        return true
    } else {
        return false
    }
}
func arrayCleaning (array: [Int]) -> [Int] {
    var cleanedArray: Array <Int> = []
    for i in 0..<array.count {
        if oddNumber(checkedNumber: array[i]) && divisibleByThreeNumber(checkedNumber: array[i]) {
            cleanedArray.append(array[i])
        }
    }
    return cleanedArray
}
print(arrayCleaning(array: array100Alternative))
print("------------------------------------------------\n")


/*
 Задание 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов. Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
 В качестве первого элемента примем число 0 --> 0, 1, 1, 2, 3 и т.д. (в то же время, в некоторых источниках допускается начинать счет с 1 --> 1, 1, 2, 3 и т.д., что также является верным).
 */
print("Задание 5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.")
print("Начальные условия: Общее количество чисел Фибоначчи равно 100")
print("Решение:")

// Рекурсивная функция fibonacciNumbersGenerator генерирует массив чисел Фибоначчи.
func fibonacciNumbersGenerator (fiboNum1: Double, fiboNum2: Double, fiboNum3: Double, numberOfElements: Int, tempFiboArray: [Double]) -> [Double] {
    var fibonacciArray: Array <Double> = tempFiboArray
    var stopCount = numberOfElements
    
    fibonacciArray.append(fiboNum3)
    
    let fibonacciNumber1 = fiboNum2
    let fibonacciNumber2 = fiboNum3
    let fibonacciNumber3 = fibonacciNumber1 + fibonacciNumber2
    
    stopCount -= 1
    if stopCount == 0 { // условие при котором останавливается процесс рекурсии
        return fibonacciArray
    }
    return fibonacciNumbersGenerator(fiboNum1: fibonacciNumber1, fiboNum2: fibonacciNumber2, fiboNum3: fibonacciNumber3, numberOfElements: stopCount, tempFiboArray: fibonacciArray)
}

var startNumberOfElements = 300 // Задаем количество чисел Фибоначчи
var initialFibonacciArray: Array <Double> = []
var fibo1: Double = 0
var fibo2: Double = 1
var fibo3: Double = fibo1 + fibo2

initialFibonacciArray.append(fibo1)
initialFibonacciArray.append(fibo2)
startNumberOfElements -= 2

print("Массив из \(startNumberOfElements+2) чисел Фибоначчи:")
print(fibonacciNumbersGenerator(fiboNum1: fibo1, fiboNum2: fibo2, fiboNum3: fibo3, numberOfElements: startNumberOfElements, tempFiboArray: initialFibonacciArray))
print("------------------------------------------------\n")


/*
 Задание 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
 a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
 b. Пусть переменная p изначально равна двум — первому простому числу.
 c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
 d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
 e. Повторять шаги c и d, пока возможно.
 */
print("Задание 6. Заполнить массив из 100 элементов различными простыми числами.")
print("Начальные условия: Отсутствуют.")
print("Решение:")
// Рекурсивная функция primeNumbersFinder формирует массив из 100 простых чисел.
func primeNumbersFinder (checkedArray: [Int], formedArray: [Int]) -> [Int] {
    var formedFinalArray: Array <Int> = formedArray // итоговый массив, который будет наполняться простыми числами
    var tempArray: Array <Int> = [] // Временный массив для проверки чисел
    for i in 0..<checkedArray.count {
        if !(checkedArray[i].isMultiple(of: checkedArray[0])) {
            tempArray.append(checkedArray[i]) // заполняется временный массив для последующей проверки
        }
    }
    formedFinalArray.append(checkedArray[0]) // записывается простое число в итоговый массив
    if tempArray.count == 0 { // условие при котором останавливается процесс рекурсии - когда больше нет чисел для проверки во временном массиве
        return formedFinalArray
    }
    return primeNumbersFinder(checkedArray: tempArray, formedArray: formedFinalArray)
}

var initialArray: Array <Int> = []
var finalArray: Array <Int> = []

// Задается последнее число в проверяемом массиве.
// Для получения 100 простых чисел потребуется начальный массив от 2 до 541
let lastArrayNumber: Int = 541

// Массив заполняется целыми числами от 2 до lastArrayNumber
for i in 2...lastArrayNumber {
    initialArray.append(i)
}

print("Массив из 100 простых чисел:")
print(primeNumbersFinder(checkedArray: initialArray, formedArray: finalArray))
print("------------------------------------------------\n")
