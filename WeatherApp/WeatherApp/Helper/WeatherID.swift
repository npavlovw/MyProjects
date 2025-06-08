//
//  WeatherID.swift
//  WeatherApp
//
//  Created by Никита Павлов on 08.06.2025.
//

import Foundation

class WeatherID {
    
    func descriptionForWeatherId(_ id: Int) -> String {
        switch id {
        case 200:
            return "Гроза с небольшим дождём"
        case 201:
            return "Гроза с дождем"
        case 202:
            return "Гроза с сильным дождем"
        case 210:
            return "Небольшая гроза"
        case 211:
            return "Гроза"
        case 212, 221:
            return "Сильная гроза"
        case 230:
            return "Гроза с небольшим моросящим дождем"
        case 231:
            return "Гроза с моросью"
        case 232:
            return "Гроза с сильным моросящим дождем"
        case 300, 301:
            return "Морось"
        case 302, 312:
            return "Сильный моросящий дождь"
        case 310:
            return "Слабый моросящий дождь"
        case 311:
            return "Моросящий дождь"
        case 313, 521:
            return "Ливень"
        case 314:
            return "Сильный ливень"
        case 321:
            return "Моросящий дождь"
        case 500:
            return "Неболльшой дождь"
        case 501:
            return "Умеренный дождь"
        case 502, 504:
            return "Сильный ливень"
        case 503:
            return "Очень сильный дождь"
        case 511:
            return "Ледяной дождь"
        case 520:
            return "Слабый ливень"
        case 522, 531:
            return "Сильный ливень"
        case 600:
            return "Небольшой снег"
        case 601:
            return "Снег"
        case 602:
            return "Сильный снегопад"
        case 611:
            return "Мокрый снег"
        case 612:
            return "Небольшой ливень со снегом"
        case 613:
            return "Ливень со снегом"
        case 615:
            return "Небольшой дождь со снегом"
        case 616:
            return "Дождь и снег"
        case 620:
            return "Небольшой ливневый снег"
        case 621:
            return "Ливневый снег"
        case 622:
            return "Сильный ливненвый снег"
        case 701...781:
            return "Туман"
        case 800:
            return "Ясное небо"
        case 801...804:
            return "Облачно"
        default:
            return "Неизвестно"
        }
    }
    
    func imageForWeatherId(_ id: Int) -> String {
        switch id {
        case 800:
            return "Ясное небо"
        case 801, 802:
            return "Рассеянные облака"
        case 803, 804:
            return "Разорванные облака"
        case 300...321, 520...531:
            return "Ливень"
        case 500...504:
            return "Дождь"
        case 200...232:
            return "Гроза"
        case 600...622:
            return "Снег"
        case 701...781:
            return "Туман"
        default:
            return "Неизвестно"
        }
    }
}
