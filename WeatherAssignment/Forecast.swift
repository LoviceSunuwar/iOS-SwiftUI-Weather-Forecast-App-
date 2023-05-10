//
//  Forecast.swift
//  WeatherAssignment
//
//  Created by Lovice Sunuwar on 09/05/2023.
//

import UIKit
import CoreLocation

struct Forecast: Codable {
    struct List: Codable{
        let dt: Date
        let pop: Double
        struct Main: Codable {
            let temp_min: Double
            let temp_max:Double
        }
        let main: Main
    }
    let list: [List]
}
