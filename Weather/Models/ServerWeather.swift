//
//  Weather.swift
//  Weather
//
//  Created by Alex on 02.11.2020.
//

import Foundation

struct ServerWeather: Decodable {
    let now: TimeInterval
    let fact: Fact
    let forecast: Forecast
}

struct Fact: Decodable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Float
    let windDir: String
    let pressureMm: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case humidity
    }
}

struct Forecast: Decodable {
    let date: String
    let week: Int
    let sunrise: String
    let sunset: String
    let moonCode: Int
    let parts: [Part]
    
    enum CodingKeys: String, CodingKey {
        case date
        case week
        case sunrise
        case sunset
        case moonCode = "moon_code"
        case parts
    }
}

struct Part: Decodable {
    let partName: String
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let icon: String
    let condition: String
    let windSpeed: Float
    let windGust: Float
    let windDir: String
    let pressureMm: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case partName = "part_name"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case icon
        case condition
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case humidity
    }
}

/*
 
 Optional("{
 \"now\":1603708972,
 \"now_dt\":\"2020-10-26T10:42:52.114Z\",
 \"info\":{\"lat\":55.75396,\"lon\":37.620393,\"url\":\"https://yandex.ru/pogoda/?lat=55.75396&lon=37.620393\"},
 
 \"fact\":{\"temp\":11,\"feels_like\":10,\"icon\":\"ovc\",\"condition\":\"overcast\",\"wind_speed\":0.8,\"wind_gust\":2.6,\"wind_dir\":\"s\",\"pressure_mm\":752,\"pressure_pa\":1003,\"humidity\":74,\"daytime\":\"d\",\"polar\":false,\"season\":\"autumn\",\"obs_time\":1603708440},
 
 \"forecast\":{\"date\":\"2020-10-26\",\"date_ts\":1603659600,\"week\":44,\"sunrise\":\"07:23\",\"sunset\":\"17:02\",\"moon_code\":13,\"moon_text\":\"moon-code-13\",\"parts\":[{\"part_name\":\"evening\",\"temp_min\":8,\"temp_max\":10,\"temp_avg\":9,\"feels_like\":7,\"icon\":\"bkn_n\",\"condition\":\"cloudy\",\"daytime\":\"n\",\"polar\":false,\"wind_speed\":2,\"wind_gust\":4.6,\"wind_dir\":\"se\",\"pressure_mm\":754,\"pressure_pa\":1006,\"humidity\":87,\"prec_mm\":0,\"prec_period\":360,\"prec_prob\":0}
 ,{\"part_name\":\"night\",\"temp_min\":7,\"temp_max\":8,\"temp_avg\":8,\"feels_like\":5,\"icon\":\"ovc\",\"condition\":\"overcast\",\"daytime\":\"n\",\"polar\":false,\"wind_speed\":2.5,\"wind_gust\":6,\"wind_dir\":\"se\",\"pressure_mm\":754,\"pressure_pa\":1006,\"humidity\":90,\"prec_mm\":0,\"prec_period\":360,\"prec_prob\":0}
 ]}}")
 
 
 
({
    fact =     {
        condition = overcast;
        daytime = d;
        "feels_like" = 9;
        humidity = 68;
        icon = ovc;
        "obs_time" = 1603707205;
        polar = 0;
        "pressure_mm" = 752;
        "pressure_pa" = 1003;
        season = autumn;
        temp = 11;
        "wind_dir" = nw;
        "wind_gust" = "2.6";
        "wind_speed" = 1;
    };
 
 
 
 
    forecast =     {
        date = "2020-10-26";
        "date_ts" = 1603659600;
        "moon_code" = 13;
        "moon_text" = "moon-code-13";
        
        
        parts =         (
                        {
                condition = cloudy;
                daytime = n;
                "feels_like" = 7;
                humidity = 87;
                icon = "bkn_n";
                "part_name" = evening;
                polar = 0;
                "prec_mm" = 0;
                "prec_period" = 360;
                "prec_prob" = 0;
                "pressure_mm" = 754;
                "pressure_pa" = 1006;
                "temp_avg" = 9;
                "temp_max" = 10;
                "temp_min" = 8;
                "wind_dir" = se;
                "wind_gust" = "4.6";
                "wind_speed" = 2;
            },
                        {
                condition = overcast;
                daytime = n;
                "feels_like" = 5;
                humidity = 90;
                icon = ovc;
                "part_name" = night;
                polar = 0;
                "prec_mm" = 0;
                "prec_period" = 360;
                "prec_prob" = 0;
                "pressure_mm" = 754;
                "pressure_pa" = 1006;
                "temp_avg" = 8;
                "temp_max" = 8;
                "temp_min" = 7;
                "wind_dir" = se;
                "wind_gust" = 6;
                "wind_speed" = "2.5";
            }
        );
        sunrise = "07:23";
        sunset = "17:02";
        week = 44;
    };
    info =     {
        lat = "55.75396";
        lon = "37.620393";
        url = "https://yandex.ru/pogoda/?lat=55.75396&lon=37.620393";
    };
    now = 1603707912;
    "now_dt" = "2020-10-26T10:25:12.762Z";
})

*/
