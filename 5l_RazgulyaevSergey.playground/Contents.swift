import Foundation

/*
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 */

enum Manufacturers: String {
    case audi = "Audi"
    case bmw = "BMW"
    case mercedesBenz = "Mercedes-Benz"
    case man = "MAN"
    case scania = "Scania"
    case volvo = "Volvo"
}
enum CarModels: String {
    // Audi
    case audiA3Sportback = "A3 Sportback"
    case audiA4 = "A4"
    case audiA4Allroad = "A4 Allroad"
    case audiQ3 = "Q3"
    // BMW
    case bmw3 = "3 Series"
    case bmw3M = "3 Series M"
    case bmw5 = "5 Series"
    case bmwX5 = "X5"
    // Mercedes-Benz
    case mercedesBenzCSedan = "C Sedan"
    case mercedesBenzCCoupe = "C Coupe"
    case mercedesBenzEEstate = "E Estate"
    case mercedesBenzSCoupeAMG = "S Coupe AMG"
    case mercedesBenzV = "V"
    // MAN
    case manTGXW = "TGSW" // фура (тягач + прицеп)
    case manTGM = "TGM" // грузовой фургон
    case manTGL = "TGL" // малый грузовой фургон без прицепа
    case manTGX = "TGX" // тягач
    case manTGS = "TGS" // самосвал
    // Scania
    case scaniaPW = "PW" // фура (тягач + прицеп)
    case scaniaP = "P" // тягач
    case scaniaXT = "XT" // самосвал
    case scaniaFT = "FT" // противопожарная техника
    // Volvo
    case volvoFH = "FH" // фура (тягач + прицеп)
    case volvoFL = "FL" // грузовой фургон
    case volvoFM = "FM" // тягач
    case volvoFMX = "FMX" // самосвал
}
enum BodyColors: String {
    case black = "Черный"
    case blue = "Синий"
    case green = "Зеленый"
    case red = "Красный"
    case white = "Белый"
    case yellow = "Желтый"
}
enum CarsBodyType: String {
    case coupe = "Купе"
    case crossover = "Кроссовер"
    case hatchback = "Хетчбэк"
    case sedan = "Седан"
    case universal = "Универсал"
    case dumpTruck = "Самосвал"
    case tractorUnit = "Тягач (без прицепа)"
    case van = "Фургон"
    case wagon = "Фура"
}
enum EngineType: String {
    case diesel = "Дизельный"
    case gas = "Бензиновый"
    case hybrid = "Гибридный"
    case electric = "Электрический"
}
enum Transmission: String {
    case automatic = "АКПП"
    case manual = "МКП"
    case robotic = "Робот"
    case variator = "Вариатор"
}
// Общие действия с автомобилями
enum VehicleGeneralAction {
    case engineOn
    case engineOff
    case windowsOpen
    case windowsClose
}
// Специфичные действия с автомобилями
enum VehicleSpecificAction {
    case cargoDoorOpen
    case cargoDoorClose
    case forsageModeOn
    case forsageModeOff
}

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
protocol CarActionExecutable: class {
    var manufacturer: Manufacturers { get }
    var model: CarModels { get }
    var yearOfManufacture: Int { get set }
    var color: BodyColors { get }
    var carsBodyType: CarsBodyType { get }
    var engineType: EngineType { get }
    var enginePower: Double { get set }
    var transmission: Transmission { get }
    var engineStatusRunning: Bool { get set }
    var windowsStatusOpen: Bool { get set }
    
    func engineOnAction(action: VehicleGeneralAction)
    func engineOffAction(action: VehicleGeneralAction)
    func windowsOpenAction(action: VehicleGeneralAction)
    func windowsCloseAction(action: VehicleGeneralAction)
    func specificAction(action: VehicleSpecificAction)
}

// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

// engineOn
extension CarActionExecutable {
    func engineOnAction(action: VehicleGeneralAction) {
        if action == .engineOn {
            guard !engineStatusRunning else {
                print("Внимание, ошибка! Двигатель уже был запущен ранее.")
                return
            }
            engineStatusRunning = true
            print("Двигатель запущен.")
        } else {
            print("Ошибка! Выберите действие: .engineOn")
        }
    }
}
// engineOff
extension CarActionExecutable {
    func engineOffAction(action: VehicleGeneralAction) {
        if action == .engineOff {
            guard engineStatusRunning else {
                print("Внимание! Двигатель уже был остановлен ранее.")
                return
            }
            engineStatusRunning = false
            print("Двигатель остановлен.")
        } else {
            print("Ошибка! Выберите действие: .engineOff")
        }
    }
}
// windowsOpen
extension CarActionExecutable {
    func windowsOpenAction(action: VehicleGeneralAction) {
        if action == .windowsOpen {
            guard !windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были открыты ранее.")
                return
            }
            windowsStatusOpen = true
            print("Окна открыты.")
        } else {
            print("Ошибка! Выберите действие: .windowsOpen")
        }
    }
}
// windowsClose
extension CarActionExecutable {
    func windowsCloseAction(action: VehicleGeneralAction) {
        if action == .windowsClose {
            guard windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были закрыты ранее.")
                return
            }
            windowsStatusOpen = false
            print("Окна закрыты.")
        } else {
            print("Ошибка! Выберите действие: .windowsClose")
        }
    }
}

//3.1 Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
class TrunkCar: CarActionExecutable {
    var manufacturer: Manufacturers
    var model: CarModels
    var yearOfManufacture: Int
    var color: BodyColors
    var carsBodyType: CarsBodyType
    var engineType: EngineType
    var enginePower: Double
    var transmission: Transmission
    var engineStatusRunning: Bool = false // изначально двигатель не работает
    var windowsStatusOpen: Bool = false // изначально окна закрыты
    
    var cargoWeightInCargoCompartment: Double
    var cargoDoorStatusOpen: Bool
    
    init(manufacturer: Manufacturers, model: CarModels, yearOfManufacture: Int, color: BodyColors, carsBodyType: CarsBodyType, engineType: EngineType, enginePower: Double, transmission: Transmission, cargoWeightInCargoCompartment: Double) {
        self.manufacturer = manufacturer
        self.model = model
        self.yearOfManufacture = yearOfManufacture
        self.color = color
        self.carsBodyType = carsBodyType
        self.engineType = engineType
        self.enginePower = enginePower
        self.transmission = transmission
        self.cargoWeightInCargoCompartment = cargoWeightInCargoCompartment
        self.cargoDoorStatusOpen = false // изначально грузовая дверь закрыта
    }
    // engineOn
    func engineOnAction(action: VehicleGeneralAction) {
        if action == .engineOn {
            guard !engineStatusRunning else {
                print("Внимание, ошибка! Двигатель уже был запущен ранее.")
                return
            }
            engineStatusRunning = true
            print("Двигатель запущен.")
        } else {
            print("Ошибка! Выберите действие: .engineOn")
        }
    }
    // engineOff
    func engineOffAction(action: VehicleGeneralAction) {
        if action == .engineOff {
            guard engineStatusRunning else {
                print("Внимание! Двигатель уже был остановлен ранее.")
                return
            }
            engineStatusRunning = false
            print("Двигатель остановлен.")
        } else {
            print("Ошибка! Выберите действие: .engineOff")
        }
    }
    // windowsOpen
    func windowsOpenAction(action: VehicleGeneralAction) {
        if action == .windowsOpen {
            guard !windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были открыты ранее.")
                return
            }
            windowsStatusOpen = true
            print("Окна открыты.")
        } else {
            print("Ошибка! Выберите действие: .windowsOpen")
        }
    }
    // windowsClose
    func windowsCloseAction(action: VehicleGeneralAction) {
        if action == .windowsClose {
            guard windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были закрыты ранее.")
                return
            }
            windowsStatusOpen = false
            print("Окна закрыты.")
        } else {
            print("Ошибка! Выберите действие: .windowsClose")
        }
    }
    func specificAction(action: VehicleSpecificAction) {
        switch action {
        case .cargoDoorOpen:
            guard !cargoDoorStatusOpen else {
                print("Внимание, ошибка! Грузовая дверь уже была открыта ранее.")
                return
            }
            cargoDoorStatusOpen = true
            print("Грузовая дверь открыта.")
        case .cargoDoorClose:
            guard cargoDoorStatusOpen else {
                print("Внимание, ошибка! Грузовая дверь уже была закрыта ранее.")
                return
            }
            cargoDoorStatusOpen = false
            print("Грузовая дверь закрыта.")
        default:
            print("Выбранное специфичное действие не поддерживается данным типом автомобиля")
        }
    }
}
//4.1 Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Производитель: \(manufacturer.rawValue)\nМодель: \(model.rawValue)\nГод выпуска: \(yearOfManufacture) год\nЦвет кузова: \(color.rawValue)\nТип кузова: \(carsBodyType.rawValue)\nТип двигателя: \(engineType.rawValue)\nМощность двигателя: \(enginePower) л.с.\nТип трансмиссии: \(transmission.rawValue)\nМасса груза в грузовом отсеке: \(cargoWeightInCargoCompartment) кг\n"
    }
}
//3.2 Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
class SportCar: CarActionExecutable {
    var manufacturer: Manufacturers
    var model: CarModels
    var yearOfManufacture: Int
    var color: BodyColors
    var carsBodyType: CarsBodyType
    var engineType: EngineType
    var enginePower: Double
    var transmission: Transmission
    var engineStatusRunning: Bool = false // изначально двигатель не работает
    var windowsStatusOpen: Bool = false // изначально окна закрыты
    
    var numberOfSportTurbines: Int
    var engineForsageMode: Bool
    
    init(manufacturer: Manufacturers, model: CarModels, yearOfManufacture: Int, color: BodyColors, carsBodyType: CarsBodyType, engineType: EngineType, enginePower: Double, transmission: Transmission, numberOfSportTurbines: Int) {
        self.manufacturer = manufacturer
        self.model = model
        self.yearOfManufacture = yearOfManufacture
        self.color = color
        self.carsBodyType = carsBodyType
        self.engineType = engineType
        self.enginePower = enginePower
        self.transmission = transmission
        self.numberOfSportTurbines = numberOfSportTurbines
        self.engineForsageMode = false // изначально форсаж отключен
    }
    // engineOn
    func engineOnAction(action: VehicleGeneralAction) {
        if action == .engineOn {
            guard !engineStatusRunning else {
                print("Внимание, ошибка! Двигатель уже был запущен ранее.")
                return
            }
            engineStatusRunning = true
            print("Двигатель запущен.")
        } else {
            print("Ошибка! Выберите действие: .engineOn")
        }
    }
    // engineOff
    func engineOffAction(action: VehicleGeneralAction) {
        if action == .engineOff {
            guard engineStatusRunning else {
                print("Внимание! Двигатель уже был остановлен ранее.")
                return
            }
            engineStatusRunning = false
            print("Двигатель остановлен.")
        } else {
            print("Ошибка! Выберите действие: .engineOff")
        }
    }
    // windowsOpen
    func windowsOpenAction(action: VehicleGeneralAction) {
        if action == .windowsOpen {
            guard !windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были открыты ранее.")
                return
            }
            windowsStatusOpen = true
            print("Окна открыты.")
        } else {
            print("Ошибка! Выберите действие: .windowsOpen")
        }
    }
    // windowsClose
    func windowsCloseAction(action: VehicleGeneralAction) {
        if action == .windowsClose {
            guard windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были закрыты ранее.")
                return
            }
            windowsStatusOpen = false
            print("Окна закрыты.")
        } else {
            print("Ошибка! Выберите действие: .windowsClose")
        }
    }
    func specificAction(action: VehicleSpecificAction) {
        switch action {
        case .forsageModeOn:
            guard !engineForsageMode else {
                print("Внимание, ошибка! Форсаж уже был включен ранее.")
                return
            }
            engineForsageMode = true
            print("Форсаж включен.")
        case .forsageModeOff:
            guard engineForsageMode else {
                print("Внимание, ошибка! Форсаж уже был отключен ранее.")
                return
            }
            engineForsageMode = false
            print("Форсаж отключен.")
        default:
            print("Выбранное специфичное действие не поддерживается данным типом автомобиля")
        }
    }
}
//4.2 Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension SportCar: CustomStringConvertible {
    var description: String {
        return "Производитель: \(manufacturer.rawValue)\nМодель: \(model.rawValue)\nГод выпуска: \(yearOfManufacture) год\nЦвет кузова: \(color.rawValue)\nТип кузова: \(carsBodyType.rawValue)\nТип двигателя: \(engineType.rawValue)\nМощность двигателя: \(enginePower) л.с.\nТип трансмиссии: \(transmission.rawValue)\nКоличество спортивных турбин в двигателе: \(numberOfSportTurbines)\n"
    }
}

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.
var mailVan = TrunkCar(manufacturer: .mercedesBenz, model: .mercedesBenzV, yearOfManufacture: 2017, color: .yellow, carsBodyType: .van, engineType: .diesel, enginePower: 190, transmission: .robotic, cargoWeightInCargoCompartment: 50.3)
print("Характеристики почтового фургона:")
print(mailVan)
print("Взаимодействие с почтовым фургоном:")
mailVan.engineOnAction(action: .engineOn)
mailVan.engineOffAction(action: .engineOff)
mailVan.windowsOpenAction(action: .windowsOpen)
mailVan.windowsCloseAction(action: .windowsClose)
mailVan.specificAction(action: .cargoDoorOpen)
mailVan.specificAction(action: .cargoDoorClose)
mailVan.specificAction(action: .forsageModeOn)
print("-----------------------------------")
print("")

var dumpTruck = TrunkCar(manufacturer: .volvo, model: .volvoFH, yearOfManufacture: 2007, color: .green, carsBodyType: .wagon, engineType: .diesel, enginePower: 556.8, transmission: .automatic, cargoWeightInCargoCompartment: 3500)
print("Характеристики фуры:")
print(dumpTruck)
print("Взаимодействие с фурой:")
dumpTruck.engineOnAction(action: .engineOn)
dumpTruck.engineOffAction(action: .engineOff)
dumpTruck.windowsOpenAction(action: .windowsOpen)
dumpTruck.windowsCloseAction(action: .windowsClose)
dumpTruck.specificAction(action: .cargoDoorOpen)
dumpTruck.specificAction(action: .cargoDoorClose)
dumpTruck.specificAction(action: .forsageModeOff)
print("-----------------------------------")
print("")

var formulaOneSafetyCar = SportCar(manufacturer: .mercedesBenz, model: .mercedesBenzSCoupeAMG, yearOfManufacture: 2020, color: .white, carsBodyType: .coupe, engineType: .gas, enginePower: 630, transmission: .automatic, numberOfSportTurbines: 2)
print("Характеристики автомобиля безопасности для Formula 1:")
print(formulaOneSafetyCar)
print("Взаимодействие с автомобилем безопасности для Formula 1:")
formulaOneSafetyCar.engineOnAction(action: .engineOn)
formulaOneSafetyCar.engineOffAction(action: .engineOff)
formulaOneSafetyCar.windowsOpenAction(action: .windowsOpen)
formulaOneSafetyCar.windowsCloseAction(action: .windowsClose)
formulaOneSafetyCar.specificAction(action: .forsageModeOn)
formulaOneSafetyCar.specificAction(action: .forsageModeOff)
formulaOneSafetyCar.specificAction(action: .cargoDoorOpen)
print("-----------------------------------")
print("")

var streetRacerCar = SportCar(manufacturer: .bmw, model: .bmw3M, yearOfManufacture: 2014, color: .red, carsBodyType: .sedan, engineType: .gas, enginePower: 775.8, transmission: .manual, numberOfSportTurbines: 2)
print("Характеристики автомобиля для стрит рэйсинга:")
print(streetRacerCar)
print("Взаимодействие с автомобилем для стрит рэйсинга:")
streetRacerCar.engineOnAction(action: .engineOn)
streetRacerCar.engineOffAction(action: .engineOff)
streetRacerCar.windowsOpenAction(action: .windowsOpen)
streetRacerCar.windowsCloseAction(action: .windowsClose)
streetRacerCar.specificAction(action: .forsageModeOn)
streetRacerCar.specificAction(action: .forsageModeOff)
streetRacerCar.specificAction(action: .cargoDoorOpen)
print("-----------------------------------")
print("")
