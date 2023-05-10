//
//  ForecastViewModel.swift
//  WeatherAssignment
//
//  Created by Lovice Sunuwar on 09/05/2023.
//

import Foundation

struct ForecastViewModel{
    let forecast: Forecast.List
//    var system: Int
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var popNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    var day: String{
        return Self.dateFormatter.string(from: forecast.dt)
    }
    
    var maxTemp: String {
        return "High 🔺: \(Self.numberFormatter.string(for: forecast.main.temp_max) ?? "0")°c"
    }
    
    var minTemp: String {
        return "Low 🔻: \(Self.numberFormatter.string(for: forecast.main.temp_min) ?? "0")°c"
    }
    
    var pop: String {
        return "precipitation 💧 : \(Self.popNumberFormatter.string(for: forecast.pop) ?? "0%")"
    }
//    var overview: String {
//        forecast.
//    }
}
