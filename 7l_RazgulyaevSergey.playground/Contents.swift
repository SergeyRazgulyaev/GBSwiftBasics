import Foundation

// Урок 7. Домашняя работа.

//1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
//2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.


// протокол, описывающий требования к автомобилю, паркуемому на автоматизированную парковку
protocol AbleToPark {
    var parkingWallet: Double { get set }
    var individualParkingPlaceNumber: Int? { get set }
    var owner: String { get }
    var carNumber: String { get }
    var model: String { get }
    var vinNumber: String { get }
}

// класс "Паркуемый автомобиль", отвечающий требованиям протокола AbleToPark
class ParkedCar: AbleToPark, CustomStringConvertible {
    var parkingWallet: Double = 0.0 // изначально парковочный кошелек пуст
    var individualParkingPlaceNumber: Int? = nil // изначально индивидуальное место для парковки не назначено
    let owner: String
    let carNumber: String
    let model: String
    let vinNumber: String
    
    init(owner: String, carNumber: String, model: String, vinNumber: String) {
        self.owner = owner
        self.carNumber = carNumber
        self.model = model
        self.vinNumber = vinNumber
    }
    // пополнение парковочного кошелька
    func addMoneyToParkingWallet(amountOfAddMoney: Double) -> Double {
        parkingWallet += amountOfAddMoney
        print("Вы успешно положили \(amountOfAddMoney) руб. на парковочный кошелек \(model) of \(owner).\nИтоговая сумма в парковочном кошельке \(model) of \(owner): \(parkingWallet) руб.")
        return parkingWallet
    }
    // снятие денег с парковочного кошелька
    func withdrawMoneyFromParkingWallet(amountOfWithdrawMoney: Double) -> Double {
        guard parkingWallet >= amountOfWithdrawMoney else {
            print("Вы не можете снять \(amountOfWithdrawMoney) руб. с парковочного кошелька. Недостаточно средств.\nНа вашем счету всего \(parkingWallet) руб.")
            return parkingWallet
        }
        parkingWallet -= amountOfWithdrawMoney
        print("Вы успешно сняли \(amountOfWithdrawMoney) руб. с парковочного кошелька \(model) of \(owner).")
        return parkingWallet
    }
    var description: String {
        return "\(model) of \(owner)"
    }
}

// ошибки, которые могут возникать при работе Автоматизированной парковки
enum AutomatedParkingError: Error {
    case fullParking // парковка заполнена, вободных мест нет
    case duplicateParking // попытка повторно припарковать автомобиль
    case parkingNotPaid(requiredAdditionalPayment: Double) // парковка не оплачена, указывается сумма, необходимая к внесению в парковочный кошелек
    case carIsMissing // автомобиль отсутствует на парковке
    case emptyParkingPlace // пустая парковка, автомобиль забрать нельзя
}

// класс Автоматизированная парковка
class AutomatedParking: CustomStringConvertible {
    var numberOfParkingPlaces: Int // общее количество мест на парковке
    var freeParkingPlaces: Int // количество свободных для парковки мест
    var parkingPlaceID: Int = 1 // первое парковочное место
    var parkedCarDictionary: Dictionary <Int, ParkedCar> = [:] // словарь припаркованных автомобилей
    var parkedCarArray: Array <ParkedCar> = [] // массив припаркованных автомобилей
    var parkingCost: Double // стоимость парковки
    
    init(numberOfParkingPlaces: Int, freeParkingPlaces: Int, parkingCost: Double) {
        self.numberOfParkingPlaces = numberOfParkingPlaces
        self.freeParkingPlaces = freeParkingPlaces
        self.parkingCost = parkingCost
    }
    
    // ошибки реализации данной функции отрабатываются с помощью try/catch
    func parkCar(parkedCar: ParkedCar) throws -> ParkedCar {
        guard freeParkingPlaces > 0 else {
            throw AutomatedParkingError.fullParking
        }
        guard parkedCar.individualParkingPlaceNumber == nil else {
            throw AutomatedParkingError.duplicateParking
        }
        parkedCar.individualParkingPlaceNumber = parkingPlaceID
        parkedCarDictionary[parkedCar.individualParkingPlaceNumber!] = parkedCar
        parkingPlaceID += 1
        freeParkingPlaces = numberOfParkingPlaces - parkedCarDictionary.count
        print("Автомобиль \(parkedCar) припаркован.")
        if parkedCar.parkingWallet < parkingCost {
            print("Не забудьте пополнить парковочный кошелек перед выездом. У Вас не достаточно средств для оплаты парковки.\nНа вашем счету \(parkedCar.parkingWallet) руб.")
        }
        print("На парковке стоят автомобили: \(parking.parkedCarDictionary).\nСвободных мест на парковке: \(parking.freeParkingPlaces).\n")
        return parkedCar
    }
    
    // ошибки реализации данной функции отрабатываются с помощью Error
    func unParkCar(parkedCar: ParkedCar) -> (ParkedCar?, AutomatedParkingError?) {
        guard !(parkedCarDictionary.isEmpty) else {
            return (nil, AutomatedParkingError.emptyParkingPlace)
        }
        guard parkedCar.individualParkingPlaceNumber != nil else {
            return (nil, AutomatedParkingError.carIsMissing)
        }
        guard parkedCar.parkingWallet >= parkingCost else {
            return (nil, AutomatedParkingError.parkingNotPaid(requiredAdditionalPayment: parkingCost - parkedCar.parkingWallet))
        }
        parkedCar.parkingWallet -= parkingCost
        print("С парковочного кошелька \(parkedCar) сната сумма: \(parkingCost) руб. за парковку.\nНа вашем счету осталось \(parkedCar.parkingWallet) руб.")
        parkingPlaceID -= 1
        parkedCarDictionary[parkedCar.individualParkingPlaceNumber!] = nil
        parkedCar.individualParkingPlaceNumber = nil
        freeParkingPlaces = numberOfParkingPlaces - parkedCarDictionary.count
        print("Автомобиль \(parkedCar) выехал с парковки.")
        print("На парковке стоят автомобили: \(parking.parkedCarDictionary).\nСвободных мест на парковке: \(parking.freeParkingPlaces).\n")
        return (parkedCar, nil)
    }
    func freeParking() {
        parkedCarDictionary.removeAll()
        print("Парковка освобождена от автомобилей в ходе экстренной эвакуации.")
    }
    var description: String {
        return "Создана парковка.\nМашиномест: \(parking.numberOfParkingPlaces)\nСвободно машиномест: \(parking.freeParkingPlaces)\nСтоимость парковки составляет: \(parking.parkingCost) руб.\n"
    }
}

//создание Автоматизированной парковки
let parking = AutomatedParking(numberOfParkingPlaces: 3, freeParkingPlaces: 3, parkingCost: 200)
print(parking)

print("\n------------ Автомобили паркуются ---------------\n")

let bmw = ParkedCar(owner: "John Hunter", carNumber: "CLF3462", model: "BMW", vinNumber: "VIN384839sd839")
bmw.addMoneyToParkingWallet(amountOfAddMoney: 500)
bmw.addMoneyToParkingWallet(amountOfAddMoney: 700)

do {
    try parking.parkCar(parkedCar: bmw)
} catch AutomatedParkingError.fullParking {
    print("Нет свободных мест на парковке. Автомобиль \(bmw) не может быть припаркован")
} catch AutomatedParkingError.duplicateParking {
    print("Внимание! Автомобиль \(bmw) ранее уже был припаркован.")
} catch let error {
    print(error.localizedDescription)
}
print("")

let mercedes = ParkedCar(owner: "Philip McGregor", carNumber: "TXS8734", model: "Mercedes-Benz", vinNumber: "VIN33247fd929")
mercedes.addMoneyToParkingWallet(amountOfAddMoney: 600)
do {
    try parking.parkCar(parkedCar: mercedes)
} catch AutomatedParkingError.fullParking {
    print("Нет свободных мест на парковке. Автомобиль \(mercedes) не может быть припаркован")
} catch AutomatedParkingError.duplicateParking {
    print("Внимание! Автомобиль \(mercedes) ранее уже был припаркован.")
} catch let error {
    print(error.localizedDescription)
}
print("")

let volvo = ParkedCar(owner: "Tom Buffalo", carNumber: "GRG7364", model: "Volvo", vinNumber: "VIN22774sd8837")
do {
    try parking.parkCar(parkedCar: volvo)
} catch AutomatedParkingError.fullParking {
    print("Нет свободных мест на парковке. Автомобиль \(volvo) не может быть припаркован")
} catch AutomatedParkingError.duplicateParking {
    print("Внимание! Автомобиль \(volvo) ранее уже был припаркован.")
} catch let error {
    print(error.localizedDescription)
}

volvo.addMoneyToParkingWallet(amountOfAddMoney: 1000)
volvo.withdrawMoneyFromParkingWallet(amountOfWithdrawMoney: 900)
print("")

// отрабатывается ошибка AutomatedParkingError.fullParking
let audi = ParkedCar(owner: "Steve Donahue", carNumber: "FLR2231", model: "Audi", vinNumber: "VIN94339gh3422")
do {
    try parking.parkCar(parkedCar: audi)
} catch AutomatedParkingError.fullParking {
    print("Нет свободных мест на парковке. Автомобиль \(audi) не может быть припаркован")
} catch AutomatedParkingError.duplicateParking {
    print("Внимание! Автомобиль \(audi) ранее уже был припаркован.")
} catch let error {
    print(error.localizedDescription)
}
print("")

print("------------ Автомобили уезжают ---------------\n")

let (unParkBMWResult1, errorUnParkBMW1) = parking.unParkCar(parkedCar: bmw)
if let errorUnParkBMW1 = errorUnParkBMW1 {
    switch errorUnParkBMW1 {
    case AutomatedParkingError.parkingNotPaid(let required):
        print("Автомобиль \(bmw) не можете выехать с парковки. Не достаточно средств для оплаты парковки.\nПополните парковочный кошелек на сумму не менее \(required) руб.")
    case AutomatedParkingError.carIsMissing:
        print("Автомобиль \(bmw) отсутствует на парковке. Автомобиль забрать нельзя.")
    case AutomatedParkingError.emptyParkingPlace:
        print("Не возможно забрать \(bmw) с парковки. Вся парковка была освобождена в ходе экстренной эвакуации. Обратитесь в Администрацию.")
    default:
        print("Не определенная ошибка")
    }
}
print("")

// отрабатывается ошибка AutomatedParkingError.parkingNotPaid
let (unParkVolvoResult1, errorUnParkVolvo1) = parking.unParkCar(parkedCar: volvo)
if let errorUnParkVolvo1 = errorUnParkVolvo1 {
    switch errorUnParkVolvo1 {
    case AutomatedParkingError.parkingNotPaid(let required):
        print("Автомобиль \(volvo) не можете выехать с парковки. Не достаточно средств для оплаты парковки.\nПополните парковочный кошелек на сумму не менее \(required) руб.")
    case AutomatedParkingError.carIsMissing:
        print("Автомобиль \(volvo) отсутствует на парковке. Автомобиль забрать нельзя.")
    case AutomatedParkingError.emptyParkingPlace:
        print("Не возможно забрать \(volvo) с парковки. Вся парковка была освобождена в ходе экстренной эвакуации. Обратитесь в Администрацию.")
    default:
        print("Не определенная ошибка")
    }
}
// пополнение парковочного кошелька на сумму не менее \(parking.parkingCost - volvo.parkingWallet) руб.
volvo.addMoneyToParkingWallet(amountOfAddMoney: 100)

let (unParkVolvoResult2, errorUnParkVolvo2) = parking.unParkCar(parkedCar: volvo)
if let errorUnParkVolvo2 = errorUnParkVolvo2 {
    switch errorUnParkVolvo2 {
    case AutomatedParkingError.parkingNotPaid(let required):
        print("Автомобиль \(volvo) не можете выехать с парковки. Не достаточно средств для оплаты парковки.\nПополните парковочный кошелек на сумму не менее \(required) руб.")
    case AutomatedParkingError.carIsMissing:
        print("Автомобиль \(volvo) отсутствует на парковке. Автомобиль забрать нельзя.")
    case AutomatedParkingError.emptyParkingPlace:
        print("Не возможно забрать \(volvo) с парковки. Вся парковка была освобождена в ходе экстренной эвакуации. Обратитесь в Администрацию.")
    default:
        print("Не определенная ошибка")
    }
}
print("")

let (unParkMercedesResult1, errorUnParkMercedes1) = parking.unParkCar(parkedCar: mercedes)
if let errorUnParkMercedes1 = errorUnParkMercedes1 {
    switch errorUnParkMercedes1 {
    case AutomatedParkingError.parkingNotPaid(let required):
        print("Автомобиль \(mercedes) не можете выехать с парковки. Не достаточно средств для оплаты парковки.\nПополните парковочный кошелек на сумму не менее \(required) руб.")
    case AutomatedParkingError.carIsMissing:
        print("Автомобиль \(mercedes) отсутствует на парковке. Автомобиль забрать нельзя.")
    case AutomatedParkingError.emptyParkingPlace:
        print("Не возможно забрать \(mercedes) с парковки. Вся парковка была освобождена в ходе экстренной эвакуации. Обратитесь в Администрацию.")
    default:
        print("Не определенная ошибка")
    }
}
print("")

print("\n------------ Автомобили паркуются и уезжают ---------------\n")

audi.addMoneyToParkingWallet(amountOfAddMoney: 900)
do {
    try parking.parkCar(parkedCar: audi)
} catch AutomatedParkingError.fullParking {
    print("Нет свободных мест на парковке. Автомобиль \(audi) не может быть припаркован")
} catch AutomatedParkingError.duplicateParking {
    print("Внимание! Автомобиль \(audi) ранее уже был припаркован.")
} catch let error {
    print(error.localizedDescription)
}
print("")

// отрабатывается ошибка AutomatedParkingError.carIsMissing
let (unParkMercedesResult2, errorUnParkMercedes2) = parking.unParkCar(parkedCar: mercedes)
if let errorUnParkMercedes2 = errorUnParkMercedes2 {
    switch errorUnParkMercedes2 {
    case AutomatedParkingError.parkingNotPaid(let required):
        print("Автомобиль \(mercedes) не можете выехать с парковки. Не достаточно средств для оплаты парковки.\nПополните парковочный кошелек на сумму не менее \(required) руб.")
    case AutomatedParkingError.carIsMissing:
        print("Автомобиль \(mercedes) отсутствует на парковке. Автомобиль забрать нельзя.")
    case AutomatedParkingError.emptyParkingPlace:
        print("Не возможно забрать \(mercedes) с парковки. Вся парковка была освобождена в ходе экстренной эвакуации. Обратитесь в Администрацию.")
    default:
        print("Не определенная ошибка")
    }
}
print("")

// отрабатывается ошибка AutomatedParkingError.duplicateParking
do {
    try parking.parkCar(parkedCar: audi)
} catch AutomatedParkingError.fullParking {
    print("Нет свободных мест на парковке. Автомобиль \(audi) не может быть припаркован")
} catch AutomatedParkingError.duplicateParking {
    print("Внимание! Автомобиль \(audi) ранее уже был припаркован.")
} catch let error {
    print(error.localizedDescription)
}
print("")

do {
    try parking.parkCar(parkedCar: volvo)
} catch AutomatedParkingError.fullParking {
    print("Нет свободных мест на парковке. Автомобиль \(volvo) не может быть припаркован")
} catch AutomatedParkingError.duplicateParking {
    print("Внимание! Автомобиль \(volvo) ранее уже был припаркован.")
} catch let error {
    print(error.localizedDescription)
}
print("")

parking.freeParking()
print("На парковке стоят автомобили: \(parking.parkedCarDictionary)")
print("")

// отрабатывается ошибка AutomatedParkingError.emptyParkingPlace
let (unParkVolvoResult3, errorUnParkVolvo3) = parking.unParkCar(parkedCar: volvo)
if let errorUnParkVolvo3 = errorUnParkVolvo3 {
    switch errorUnParkVolvo3 {
    case AutomatedParkingError.parkingNotPaid(let required):
        print("Автомобиль \(volvo) не можете выехать с парковки. Не достаточно средств для оплаты парковки.\nПополните парковочный кошелек на сумму не менее \(required) руб.")
    case AutomatedParkingError.carIsMissing:
        print("Автомобиль \(volvo) отсутствует на парковке. Автомобиль забрать нельзя.")
    case AutomatedParkingError.emptyParkingPlace:
        print("Не возможно забрать \(volvo) с парковки. Вся парковка была освобождена в ходе экстренной эвакуации. Обратитесь в Администрацию.")
    default:
        print("Не определенная ошибка")
    }
}
