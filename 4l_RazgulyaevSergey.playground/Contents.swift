import Foundation

/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
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
// Общие действия с автомобилем
enum VehicleGeneralAction {
    case engineOn
    case engineOff
    case windowsOpen
    case mindowsClose
}
// Специфичные действия с автомобилем
enum VehicleSpecificAction {
    case cargoDoorOpen
    case cargoDoorClose
    case forsageModeOn
    case forsageModeOff
}

class Car {
    var manufacturer: Manufacturers
    var model: CarModels
    var yearOfManufacture: Int
    var color: BodyColors
    var carsBodyType: CarsBodyType
    var engineType: EngineType
    var enginePower: Double
    var transmission: Transmission
    var engineStatusRunning = false // изначально двигатель не работает
    var windowsStatusOpen = false // изначально окна закрыты
    
    init(manufacturer: Manufacturers, model: CarModels, yearOfManufacture: Int, color: BodyColors, carsBodyType: CarsBodyType, engineType: EngineType, enginePower: Double, transmission: Transmission) {
        self.manufacturer = manufacturer
        self.model = model
        self.yearOfManufacture = yearOfManufacture
        self.color = color
        self.carsBodyType = carsBodyType
        self.engineType = engineType
        self.enginePower = enginePower
        self.transmission = transmission
    }
    
    func specificAction(action: VehicleSpecificAction) {}
    
    func generalAction(action: VehicleGeneralAction) {
        switch action {
        case .engineOn:
            guard !engineStatusRunning else {
                print("Внимание, ошибка! Двигатель уже был запущен ранее.")
                return
            }
            engineStatusRunning = true
            print("Двигатель запущен.")
        case .engineOff:
            guard engineStatusRunning else {
                print("Внимание! Двигатель уже был остановлен ранее.")
                return
            }
            engineStatusRunning = false
            print("Двигатель остановлен.")
        case .windowsOpen:
            guard !windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были открыты ранее.")
                return
            }
            windowsStatusOpen = true
            print("Окна открыты.")
        case .mindowsClose:
            guard windowsStatusOpen else {
                print("Внимание, ошибка! Окна уже были закрыты ранее.")
                return
            }
            windowsStatusOpen = false
            print("Окна закрыты.")
        }
    }
}

class TrunkCar: Car {
    var cargoWeightInCargoCompartment: Double
    var cargoDoorStatusOpen: Bool
    
    init(manufacturer: Manufacturers, model: CarModels, yearOfManufacture: Int, color: BodyColors, carsBodyType: CarsBodyType, engineType: EngineType, enginePower: Double, transmission: Transmission, cargoWeightInCargoCompartment: Double) {
        self.cargoWeightInCargoCompartment = cargoWeightInCargoCompartment
        self.cargoDoorStatusOpen = false // изначально грузовая дверь закрыта
        super.init(manufacturer: manufacturer, model: model, yearOfManufacture: yearOfManufacture, color: color, carsBodyType: carsBodyType, engineType: engineType, enginePower: enginePower, transmission: transmission)
    }
    
    override func specificAction(action: VehicleSpecificAction) {
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

class SportCar: Car {
    var numberOfSportTurbines: Int
    var engineForsageMode: Bool
    
    init(manufacturer: Manufacturers, model: CarModels, yearOfManufacture: Int, color: BodyColors, carsBodyType: CarsBodyType, engineType: EngineType, enginePower: Double, transmission: Transmission, numberOfSportTurbines: Int) {
        self.numberOfSportTurbines = numberOfSportTurbines
        self.engineForsageMode = false // изначально форсаж отключен
        super.init(manufacturer: manufacturer, model: model, yearOfManufacture: yearOfManufacture, color: color, carsBodyType: carsBodyType, engineType: engineType, enginePower: enginePower, transmission: transmission)
    }
    override func specificAction(action: VehicleSpecificAction) {
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

var mailVan = TrunkCar(manufacturer: .mercedesBenz, model: .mercedesBenzV, yearOfManufacture: 2017, color: .yellow, carsBodyType: .van, engineType: .diesel, enginePower: 190, transmission: .robotic, cargoWeightInCargoCompartment: 50.3)
print("Характеристики почтового фургона:")
print("Производитель: \(mailVan.manufacturer.rawValue)")
print("Модель: \(mailVan.model.rawValue)")
print("Год выпуска: \(mailVan.yearOfManufacture) год")
print("Цвет кузова: \(mailVan.color.rawValue)")
print("Тип кузова: \(mailVan.carsBodyType.rawValue)")
print("Тип двигателя: \(mailVan.engineType.rawValue)")
print("Мощность двигателя: \(mailVan.enginePower) л.с.")
print("Тип трансмиссии: \(mailVan.transmission.rawValue)")
print("Масса груза в грузовом отсеке: \(mailVan.cargoWeightInCargoCompartment) кг")
print("")
print("Взаимодействие с почтовым фургоном:")
mailVan.generalAction(action: .engineOn)
mailVan.generalAction(action: .engineOff)
mailVan.generalAction(action: .windowsOpen)
mailVan.generalAction(action: .mindowsClose)
mailVan.specificAction(action: .cargoDoorOpen)
mailVan.specificAction(action: .cargoDoorClose)
mailVan.specificAction(action: .forsageModeOn)
print("-----------------------------------")
print("")

var dumpTruck = TrunkCar(manufacturer: .volvo, model: .volvoFH, yearOfManufacture: 2007, color: .green, carsBodyType: .wagon, engineType: .diesel, enginePower: 556.8, transmission: .automatic, cargoWeightInCargoCompartment: 3500)
print("Характеристики фуры:")
print("Производитель: \(dumpTruck.manufacturer.rawValue)")
print("Модель: \(dumpTruck.model.rawValue)")
print("Год выпуска: \(dumpTruck.yearOfManufacture) год")
print("Цвет кузова: \(dumpTruck.color.rawValue)")
print("Тип кузова: \(dumpTruck.carsBodyType.rawValue)")
print("Тип двигателя: \(dumpTruck.engineType.rawValue)")
print("Мощность двигателя: \(dumpTruck.enginePower) л.с.")
print("Тип трансмиссии: \(dumpTruck.transmission.rawValue)")
print("Масса груза в грузовом отсеке: \(dumpTruck.cargoWeightInCargoCompartment) кг")
print("")
print("Взаимодействие с фурой:")
dumpTruck.generalAction(action: .engineOn)
dumpTruck.generalAction(action: .engineOff)
dumpTruck.generalAction(action: .windowsOpen)
dumpTruck.generalAction(action: .mindowsClose)
dumpTruck.specificAction(action: .cargoDoorOpen)
dumpTruck.specificAction(action: .cargoDoorClose)
dumpTruck.specificAction(action: .forsageModeOff)
print("-----------------------------------")
print("")

var formulaOneSafetyCar = SportCar(manufacturer: .mercedesBenz, model: .mercedesBenzSCoupeAMG, yearOfManufacture: 2020, color: .white, carsBodyType: .coupe, engineType: .gas, enginePower: 630, transmission: .automatic, numberOfSportTurbines: 2)
print("Характеристики автомобиля безопасности для Formula 1:")
print("Производитель: \(formulaOneSafetyCar.manufacturer.rawValue)")
print("Модель: \(formulaOneSafetyCar.model.rawValue)")
print("Год выпуска: \(formulaOneSafetyCar.yearOfManufacture) год")
print("Цвет кузова: \(formulaOneSafetyCar.color.rawValue)")
print("Тип кузова: \(formulaOneSafetyCar.carsBodyType.rawValue)")
print("Тип двигателя: \(formulaOneSafetyCar.engineType.rawValue)")
print("Мощность двигателя: \(formulaOneSafetyCar.enginePower) л.с.")
print("Тип трансмиссии: \(formulaOneSafetyCar.transmission.rawValue)")
print("Количество спортивных турбин в двигателе: \(formulaOneSafetyCar.numberOfSportTurbines)")
print("")
print("Взаимодействие с автомобилем безопасности для Formula 1:")
formulaOneSafetyCar.generalAction(action: .engineOn)
formulaOneSafetyCar.generalAction(action: .engineOff)
formulaOneSafetyCar.generalAction(action: .windowsOpen)
formulaOneSafetyCar.generalAction(action: .mindowsClose)
formulaOneSafetyCar.specificAction(action: .forsageModeOn)
formulaOneSafetyCar.specificAction(action: .forsageModeOff)
formulaOneSafetyCar.specificAction(action: .cargoDoorOpen)
print("-----------------------------------")
print("")

var streetRacerCar = SportCar(manufacturer: .bmw, model: .bmw3M, yearOfManufacture: 2014, color: .red, carsBodyType: .sedan, engineType: .gas, enginePower: 775.8, transmission: .manual, numberOfSportTurbines: 2)
print("Характеристики автомобиля для стрит рэйсинга:")
print("Производитель: \(streetRacerCar.manufacturer.rawValue)")
print("Модель: \(streetRacerCar.model.rawValue)")
print("Год выпуска: \(streetRacerCar.yearOfManufacture) год")
print("Цвет кузова: \(streetRacerCar.color.rawValue)")
print("Тип кузова: \(streetRacerCar.carsBodyType.rawValue)")
print("Тип двигателя: \(streetRacerCar.engineType.rawValue)")
print("Мощность двигателя: \(streetRacerCar.enginePower) л.с.")
print("Тип трансмиссии: \(streetRacerCar.transmission.rawValue)")
print("Количество спортивных турбин в двигателе: \(streetRacerCar.numberOfSportTurbines)")
print("")
print("Взаимодействие с автомобилем для стрит рэйсинга:")
streetRacerCar.generalAction(action: .engineOn)
streetRacerCar.generalAction(action: .engineOff)
streetRacerCar.generalAction(action: .windowsOpen)
streetRacerCar.generalAction(action: .mindowsClose)
streetRacerCar.specificAction(action: .forsageModeOn)
streetRacerCar.specificAction(action: .forsageModeOff)
streetRacerCar.specificAction(action: .cargoDoorOpen)
print("-----------------------------------")
print("")
