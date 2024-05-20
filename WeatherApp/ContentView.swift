//
//  ContentView.swift
//  WeatherApp
//
//  Created by Apple on 18/05/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherViewModel = WeatherForecastViewModel()
    @State private var isNavigationActive = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Image(.day)
                VStack{
                    CurrentWeatherForecast(currentForecast: weatherViewModel.weatherData?.current , location: weatherViewModel.weatherData?.location, forecastDay: weatherViewModel.weatherData?.forecast?.forecastday?[0])
                    Text("3 Days Forecast").font(.caption).padding(.trailing,130).padding(.top,50)
                    List(weatherViewModel.weatherData?.forecast?.forecastday ?? [] , id: \.date) { forecastDay in
                        ZStack {
                            DayWeatherRow(forecastDay: forecastDay, day: weatherViewModel.formatDate(forecastDay.date ?? ""))
                        
                            NavigationLink(destination: ForecastDetails(forecastDay: forecastDay)) {
                                EmptyView()
                            }.simultaneousGesture(TapGesture().onEnded {
                                print("Hello world!")
                            }).opacity(0)
                    
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarTitle("")
                    .frame(height: 140)
                    .background(Color.clear)
                    
                    GridLayout(currentWeather: weatherViewModel.weatherData?.current)
                }
            }
        }
        .tint(.black)

        
    }
}
