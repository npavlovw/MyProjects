//
//  WeatherID.swift
//  WeatherApp
//
//  Created by Никита Павлов on 08.06.2025.
//

import Foundation
    
enum WeatherID: Int {
    case thunderstormWithLightRain = 200
    case thunderstormWithRain = 201
    case thunderstormWithHeavyRain = 202
    case lightThunderstorm = 210
    case thunderstorm = 211
    case heavyThunderstorm = 212
    case raggedThunderstorm = 221
    case thunderstormWithLightDrizzle = 230
    case thunderstormWithDrizzle = 231
    case thunderstormWithHeavyDrizzle = 232
    
    case lightDrizzle = 300
    case drizzle = 301
    case heavyDrizzle = 302
    case lightDrizzleTwo = 310
    case drizzlingRain = 311
    case heavyIntenseDrizzlingRain = 312
    case rainAndDrizzle = 313
    case heavyRainAndDrizzle = 314
    case drizzlingRainTwo = 321
    
    case lightRain = 500
    case moderateRain = 501
    case heavyRain = 502
    case veryHeavyRain = 503
    case heavyRainTwo = 504
    case freezingRain = 511
    case lightRainfallIntensity = 520
    case shower = 521
    case heavyRainShower = 522
    case raggedRainShower = 531
    
    case lightSnow = 600
    case snow = 601
    case heavySnowfall = 602
    case wetSnow = 611
    case lightShowerWithSnow = 612
    case sleet = 613
    case lightRainWithSnow = 615
    case rainAndSnow = 616
    case lightSnowShowers = 620
    case heavySnowfallTwo = 621
    case heavySnowShower = 622
    
    case fog = 701
    case smoke = 711
    case fogTwo = 721
    case sandOrDustWhirlwinds = 731
    case fogThree = 741
    case sand = 751
    case dust = 761
    case volcanicAsh = 762
    case squalls = 771
    case tornado = 781
    
    case clearSky = 800
    case slightlyCloudy = 801
    case scatteredClouds = 802
    case brokenClouds = 803
    case cloudy = 804
    
    var message: String {
        switch self {
        case .thunderstormWithLightRain:
            return "Гроза с небольшим дождём"
        case .thunderstormWithRain:
            return "Гроза с дождем"
        case .thunderstormWithHeavyRain:
            return "Гроза с сильным дождем"
        case .lightThunderstorm:
            return "Небольшая гроза"
        case .thunderstorm:
            return "Гроза"
        case .heavyThunderstorm, .raggedThunderstorm:
            return "Сильная гроза"
        case .thunderstormWithLightDrizzle:
            return "Гроза с небольшим моросящим дождем"
        case .thunderstormWithDrizzle:
            return "Гроза с моросью"
        case .thunderstormWithHeavyDrizzle:
            return "Гроза с сильным моросящим дождем"
            
        case .lightDrizzle, .drizzle:
            return "Морось"
        case .heavyDrizzle, .heavyIntenseDrizzlingRain:
            return "Сильный моросящий дождь"
        case .lightDrizzleTwo:
            return "Слабый моросящий дождь"
        case .drizzlingRain:
            return "Моросящий дождь"
        case .rainAndDrizzle, .shower:
            return "Ливень"
        case .heavyRainAndDrizzle:
            return "Сильный ливень"
        case .drizzlingRainTwo:
            return "Моросящий дождь"
            
        case .lightRain:
            return "Небольшой дождь"
        case .moderateRain:
            return "Умеренный дождь"
        case .heavyRain, .heavyRainTwo:
            return "Сильный ливень"
        case .veryHeavyRain:
            return "Очень сильный дождь"
        case .freezingRain:
            return "Ледяной дождь"
        case .lightRainfallIntensity:
            return "Слабый ливень"
        case .heavyRainShower, .raggedRainShower:
            return "Сильный ливень"
            
        case .lightSnow:
            return "Небольшой снег"
        case .snow:
            return "Снег"
        case .heavySnowfall:
            return "Сильный снегопад"
        case .wetSnow:
            return "Мокрый снег"
        case .lightShowerWithSnow:
            return "Небольшой ливень со снегом"
        case .sleet:
            return "Ливень со снегом"
        case .lightRainWithSnow:
            return "Небольшой дождь со снегом"
        case .rainAndSnow:
            return "Дождь и снег"
        case .lightSnowShowers:
            return "Небольшой ливневый снег"
        case .heavySnowfallTwo:
            return "Ливневый снег"
        case .heavySnowShower:
            return "Сильный ливненвый снег"
            
        case .fog, .fogTwo, .fogThree:
            return "Туман"
        case .smoke:
            return "Дым"
        case .sandOrDustWhirlwinds:
            return "Песчаные/пылевые бури"
        case .sand:
            return "Песок"
        case .dust:
            return "Пыль"
        case .volcanicAsh:
            return "Вулканический пепел"
        case .squalls:
            return "Шквалы"
        case .tornado:
            return "Торнадо"
            
        case .clearSky:
            return "Ясное небо"
        case .slightlyCloudy:
            return "Небольшая облачность"
        case .scatteredClouds, .brokenClouds:
            return "Рассечнные облака"
        case .cloudy:
            return "Облачно"
        }
    }
    
    var imageForWeather: String {
        switch self {
        case .clearSky:
            return "Ясное небо"
        case .slightlyCloudy, .scatteredClouds:
            return "Рассеянные облака"
        case .brokenClouds, .cloudy:
            return "Разорванные облака"
        case .lightDrizzle, .drizzle,
             .heavyDrizzle, .lightDrizzleTwo,
             .drizzlingRain, .heavyIntenseDrizzlingRain,
             .rainAndDrizzle, .heavyRainAndDrizzle,
             .drizzlingRainTwo, .lightRainfallIntensity,
             .shower, .heavyRainShower,
             .raggedRainShower:
            return "Ливень"
        case .lightRain, .moderateRain,
             .heavyRain, .veryHeavyRain,
             .heavyRainTwo, .freezingRain:
            return "Дождь"
        case .thunderstormWithLightRain, .thunderstormWithRain,
             .thunderstormWithHeavyRain, .lightThunderstorm,
             .thunderstorm, .heavyThunderstorm,
             .raggedThunderstorm, .thunderstormWithLightDrizzle,
             .thunderstormWithDrizzle, .thunderstormWithHeavyDrizzle:
            return "Гроза"
        case .lightSnow, .snow,
             .heavySnowfall, .wetSnow,
             .lightShowerWithSnow, .sleet,
             .lightRainWithSnow, .rainAndSnow,
             .lightSnowShowers, .heavySnowfallTwo,
             .heavySnowShower:
            return "Снег"
        case .fog, .smoke,
             .fogTwo, .sandOrDustWhirlwinds,
             .fogThree, .sand,
             .dust, .volcanicAsh,
             .squalls, .tornado:
            return "Туман"
            
        }
    }
}


