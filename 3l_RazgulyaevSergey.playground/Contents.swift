import Foundation

// Урок 3. Домашняя работа.

/*
1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
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
    case audiA3Sedan = "A3 Sedan"
    case audiA3Sportback = "A3 Sportback"
    case audiA4 = "A4"
    case audiA4Allroad = "A4 Allroad"
    case audiA6 = "A6"
    case audiA8 = "A8"
    case audiQ3 = "Q3"
    case audiQ5 = "Q5"
    case audiQ7 = "Q7"
    // BMW
    case bmw3 = "3 Series"
    case bmw5 = "5 Series"
    case bmw7 = "7 Series"
    case bmwX3 = "X3"
    case bmwX5 = "X5"
    case bmwX7 = "X7"
    // Mercedes-Benz
    case mercedesBenzCSedan = "C Sedan"
    case mercedesBenzCCoupe = "C Coupe"
    case mercedesBenzESedan = "E Sedan"
    case mercedesBenzEEstate = "E Estate"
    case mercedesBenzS = "S"
    case mercedesBenzSCabriolet = "S Cabriolet"
    case mercedesBenzGLS = "GLS"
    case mercedesBenzV = "V"
}
enum TruckModels: String {
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
enum CarsBodyType: String { // применимо только к легковому автомобилю
    case coupe = "Купе"
    case crossover = "Кроссовер"
    case hatchback = "Хетчбэк"
    case sedan = "Седан"
    case universal = "Универсал"
}
enum TrucksBodyType: String { // применимо только к грузовому автомобилю
    case dumpTruck = "Самосвал"
    case fireTruck = "Противопожарная техника" // (см. особенность реализации загрузки грузом)
    case refrigerator = "Холодильная автомобильная техника"
    case tractorUnit = "Тягач (без прицепа)" // (см. особенность реализации загрузки грузом)
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
enum VehicleAction {
      case engineOperatingMode
      case openWindows
      case loadCargo
}

// Структура "Легковой автомобиль"
struct Car {
    let manufacturer: Manufacturers
    let model: CarModels
    let yearOfManufacture: Int
    let color: BodyColors
    let bodyType: CarsBodyType
    let engineType: EngineType
    let enginePower: Double
    let transmission: Transmission
    let cargoMaxVolume: Int
    private var isCargoLoadedInVolume: Int = 0 // изначально пустой багажник
    private var isEngineRunning = false // изначально двигатель не работает
    private var areWindowsOpen = false // изначально окна закрыты
    
    init(manufacturer: Manufacturers, model: CarModels, yearOfManufacture: Int, color: BodyColors, bodyType: CarsBodyType, engineType: EngineType, enginePower: Double, transmission: Transmission, cargoMaxVolume: Int) {
        self.manufacturer = manufacturer
        self.model = model
        self.yearOfManufacture = yearOfManufacture
        self.color = color
        self.bodyType = bodyType
        self.engineType = engineType
        self.enginePower = enginePower
        self.transmission = transmission
        self.cargoMaxVolume = cargoMaxVolume
    }
    
    mutating func engineOperatingMode(isRunning: Bool) {
        isEngineRunning = isRunning
        print("Двигатель \(manufacturer.rawValue) \(model.rawValue) \(isRunning ? "включен" : "выключен")")
    }
    mutating func windowsPosition(open: Bool) {
        areWindowsOpen = open
        print("Окна \(manufacturer.rawValue) \(model.rawValue) \(open ? "открыты" : "закрыты")")
    }
    mutating func cargoLoad(load: Int) {
        isCargoLoadedInVolume = load
        switch isCargoLoadedInVolume {
        case 0:
            print("Багажник \(manufacturer.rawValue) \(model.rawValue) пуст")
        case 1..<(cargoMaxVolume/2):
            print("Багажник \(manufacturer.rawValue) \(model.rawValue) заполнен меньше, чем на половину. Объем груза составляет \(load) литров")
        case cargoMaxVolume/2:
            print("Багажник \(manufacturer.rawValue) \(model.rawValue) заполнен на половину. Объем груза составляет \(load) литров")
        case (cargoMaxVolume/2+1)..<cargoMaxVolume:
            print("Багажник \(manufacturer.rawValue) \(model.rawValue) заполнен больше, чем на половину. Объем груза составляет \(load) литров")
        case cargoMaxVolume:
            print("Багажник \(manufacturer.rawValue) \(model.rawValue) заполнен полностью. Объем груза составляет \(load) литров")
        default:
            print("Введено недопустимое значение для загрузки багажника! Допустимые значения: от 0 до \(cargoMaxVolume) литров")
        }
    }
}
// Структура "Грузовик"
struct Truck {
    let manufacturer: Manufacturers
    let model: TruckModels
    let yearOfManufacture: Int
    let color: BodyColors
    let bodyType: TrucksBodyType
    let engineType: EngineType
    let enginePower: Double
    let transmission: Transmission
    let cargoMaxVolume: Int
    private var isCargoLoadedInVolume: Int = 0 // изначально пустой кузов
    private var isEngineRunning = false // изначально двигатель не работает
    private var areWindowsOpen = false // изначально окна закрыты
    
    init(manufacturer: Manufacturers, model: TruckModels, yearOfManufacture: Int, color: BodyColors, bodyType: TrucksBodyType, engineType: EngineType, enginePower: Double, transmission: Transmission, cargoMaxVolume: Int) {
        self.manufacturer = manufacturer
        self.model = model
        self.yearOfManufacture = yearOfManufacture
        self.color = color
        self.bodyType = bodyType
        self.engineType = engineType
        self.enginePower = enginePower
        self.transmission = transmission
        self.cargoMaxVolume = cargoMaxVolume
    }
    
    mutating func engineOperatingMode(isRunning: Bool) {
        isEngineRunning = isRunning
        print("Двигатель \(manufacturer.rawValue) \(model.rawValue) \(isRunning ? "включен" : "выключен")")
    }
    mutating func windowsPosition(open: Bool) {
        areWindowsOpen = open
        print("Окна \(manufacturer.rawValue) \(model.rawValue) \(open ? "открыты" : "закрыты")")
    }
    mutating func cargoLoad(load: Int) {
        isCargoLoadedInVolume = load
        if self.bodyType != TrucksBodyType.tractorUnit && self.bodyType != TrucksBodyType.fireTruck {
            switch isCargoLoadedInVolume {
            case 0:
                print("Кузов \(manufacturer.rawValue) \(model.rawValue) пуст")
            case 1..<(cargoMaxVolume/2):
                print("Кузов \(manufacturer.rawValue) \(model.rawValue) заполнен меньше, чем на половину. Объем груза составляет \(load) литров")
            case cargoMaxVolume/2:
                print("Кузов \(manufacturer.rawValue) \(model.rawValue) заполнен на половину. Объем груза составляет \(load) литров")
            case (cargoMaxVolume/2+1)..<cargoMaxVolume:
                print("Кузов \(manufacturer.rawValue) \(model.rawValue) заполнен больше, чем на половину. Объем груза составляет \(load) литров")
            case cargoMaxVolume:
                print("Кузов \(manufacturer.rawValue) \(model.rawValue) заполнен полностью. Объем груза составляет \(load) литров")
            default:
                print("Введено недопустимое значение для загрузки кузова! Допустимые значения: от 0 до \(cargoMaxVolume) литров")
            }
        } else {
            print("Выбранный тип транспорта не имеет кузова. Груз не может быть загружен.")
        }
    }
}

var carAudiA4 = Car(manufacturer: .audi, model: .audiA4, yearOfManufacture: 2015, color: .green, bodyType: .sedan, engineType: .gas, enginePower: 156.4, transmission: .variator, cargoMaxVolume: 340)
print("Характеристики легкового автомобиля \(carAudiA4.manufacturer.rawValue) \(carAudiA4.model.rawValue):")
print("Производитель: \(carAudiA4.manufacturer.rawValue)")
print("Модель: \(carAudiA4.model.rawValue)")
print("Год выпуска: \(carAudiA4.yearOfManufacture) год")
print("Цвет кузова: \(carAudiA4.color.rawValue)")
print("Тип кузова: \(carAudiA4.bodyType.rawValue)")
print("Тип двигателя: \(carAudiA4.engineType.rawValue)")
print("Мощность двигателя: \(carAudiA4.enginePower) л.с.")
print("Тип трансмиссии: \(carAudiA4.transmission.rawValue)")
print("Объем багажника: \(carAudiA4.cargoMaxVolume) л.")
print("")
print("Взаимодействие с легковым автомобилем \(carAudiA4.manufacturer.rawValue) \(carAudiA4.model.rawValue):")
carAudiA4.engineOperatingMode(isRunning: true)
carAudiA4.engineOperatingMode(isRunning: false)
carAudiA4.windowsPosition(open: true)
carAudiA4.windowsPosition(open: false)
carAudiA4.cargoLoad(load: 0)
carAudiA4.cargoLoad(load: 100)
carAudiA4.cargoLoad(load: 170)
carAudiA4.cargoLoad(load: 260)
carAudiA4.cargoLoad(load: 340)
carAudiA4.cargoLoad(load: 400)
print("-----------------------------------")
print("")

var truckScaniaPW = Truck(manufacturer: .scania, model: .scaniaPW, yearOfManufacture: 2017, color: .blue, bodyType: .wagon, engineType: .hybrid, enginePower: 560, transmission: .automatic, cargoMaxVolume: 38_000)
print("Характеристики грузового автомобиля \(truckScaniaPW.manufacturer.rawValue) \(truckScaniaPW.model.rawValue):")
print("Производитель: \(truckScaniaPW.manufacturer.rawValue)")
print("Модель: \(truckScaniaPW.model.rawValue)")
print("Год выпуска: \(truckScaniaPW.yearOfManufacture) год")
print("Цвет кузова: \(truckScaniaPW.color.rawValue)")
print("Тип кузова: \(truckScaniaPW.bodyType.rawValue)")
print("Тип двигателя: \(truckScaniaPW.engineType.rawValue)")
print("Мощность двигателя: \(truckScaniaPW.enginePower) л.с.")
print("Тип трансмиссии: \(truckScaniaPW.transmission.rawValue)")
print("Объем кузова: \(truckScaniaPW.cargoMaxVolume) л.")
print("")
print("Взаимодействие с грузовым автомобилем \(truckScaniaPW.manufacturer.rawValue) \(truckScaniaPW.model.rawValue):")
truckScaniaPW.engineOperatingMode(isRunning: true)
truckScaniaPW.engineOperatingMode(isRunning: false)
truckScaniaPW.windowsPosition(open: true)
truckScaniaPW.windowsPosition(open: false)
truckScaniaPW.cargoLoad(load: 0)
truckScaniaPW.cargoLoad(load: 15_000)
truckScaniaPW.cargoLoad(load: 19_000)
truckScaniaPW.cargoLoad(load: 25_000)
truckScaniaPW.cargoLoad(load: 38_000)
truckScaniaPW.cargoLoad(load: 45_000)
print("-----------------------------------")
print("")


// В качестве примера дополнительно показан случай, когда тягач (tractorUnit) не имеет кузова, следовательно, при вызове функции cargoLoad производится проверка на возможность загрузки груза и последующее предупреждение.
var truckManTGX = Truck(manufacturer: .man, model: .manTGX, yearOfManufacture: 1998, color: .white, bodyType: .tractorUnit, engineType: .diesel, enginePower: 460, transmission: .manual, cargoMaxVolume: 0)
print("Взаимодействие с тягачем \(truckManTGX.manufacturer.rawValue) \(truckManTGX.model.rawValue):")
truckManTGX.cargoLoad(load: 30_000) // попытка разместить груз в тягаче, не имеющем кузова
print("-----------------------------------")
print("")


// В качестве примера дополнительно показан случай, когда пожарная техника не имеет кузова, следовательно, при вызове функции cargoLoad производится проверка на возможность загрузки груза и последующее предупреждение.
var truckScaniaFT = Truck(manufacturer: .scania, model: .scaniaFT, yearOfManufacture: 2019, color: .red, bodyType: .fireTruck, engineType: .diesel, enginePower: 330, transmission: .automatic, cargoMaxVolume: 0)
print("Взаимодействие с пожарной техникой \(truckScaniaFT.manufacturer.rawValue) \(truckScaniaFT.model.rawValue):")
truckScaniaFT.cargoLoad(load: 22_000)
