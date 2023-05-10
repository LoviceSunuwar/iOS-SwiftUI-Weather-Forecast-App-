//
//  ContentView.swift
//  WeatherAssignment
//
//  Created by Lovice Sunuwar on 09/05/2023.
//

import SwiftUI

struct ContentView: View {
    // Have the access to all the proerties from the viewmodel
    @StateObject private var forecastListVM = ForecastListViewModel()
    @State var searchedLocation: String = ""
   
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Enter Location", text: $forecastListVM.location).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button{
                        forecastListVM.getWeatherForecast()
                        searchedLocation = forecastListVM.location
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill") .font(.title3)
                    }
                }
          
                List(forecastListVM.forecasts, id: \.day) {
                        day in
                        VStack(alignment: .leading) {
                            Text(day.day).fontWeight(.bold)
                            HStack(alignment: .top) {
                                Image(systemName: "sunrise.circle.fill").font(.title).frame(width: 50,height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.indigo))
                                VStack(alignment: .leading){
                                    Text(day.maxTemp)
                                    Text(day.minTemp)
                                    Text(day.pop)
                                    }
                            }
                        }
                } .listStyle(PlainListStyle())
                }
                .alert(item: $forecastListVM.appError) { appError in
                    Alert(title: Text("Error"),
                          message: Text("""
                            \(appError.errorString)
                            Please try again later!
                            """
                            )
                    )
                }
                .padding(.vertical)
                .navigationTitle("Weather \(searchedLocation)")
                .refreshable {
                    await forecastListVM.getWeatherForecast()
                }
            }
        }
    }
 
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
