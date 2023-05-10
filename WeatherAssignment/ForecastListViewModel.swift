//
//  ForecastListViewModel.swift
//  WeatherAssignment
//
//  Created by Lovice Sunuwar on 09/05/2023.
//
import CoreLocation
import Foundation
import SwiftUI

class ForecastListViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var forecasts: [ForecastViewModel] = []
    var appError: AppError? = nil 
    @AppStorage("location") var location = ""
//    @AppStorage("system") var system: Int = 0 {
//           didSet {
//               for i in 0..<forecasts.count {
//                   forecasts[i].system = system
//               }
//           }
//       }
    
    init() {
            if location != "" {
                getWeatherForecast()
            }
        }
    
    func getWeatherForecast(){
        let apiService = APIService.shared
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                self.appError = AppError(errorString: error.localizedDescription)
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
                let lon = placemarks?.first?.location?.coordinate.longitude{
                apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=ced77239eed09216d116d09c51875ddb&units=metric", dateDecodingStrat: .secondsSince1970) { (result: Result<Forecast,APIService.APIError>) in
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.forecasts = forecast.list.map {ForecastViewModel(forecast: $0)}
                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            self.appError = AppError(errorString: errorString)
                            print(errorString)
                        }
                    }
                }
            }
        }
    }
    
    
}

