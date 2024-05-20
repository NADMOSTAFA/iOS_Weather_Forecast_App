//
//  CurrentWeatherForecast.swift
//  WeatherApp
//
//  Created by Apple on 19/05/2024.
//

import SwiftUI
import Kingfisher

struct CurrentWeatherForecast: View {
    var currentForecast : Current?
    var location : Location?
    var forecastDay : Forecastday?
    var body: some View {
        VStack{
            Text(location?.region ?? "").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(currentForecast?.tempC ?? 0.0, specifier: "%.1f")\u{00B0}")
                .font(.system(size: 48, design: .default))
            Text(currentForecast?.condition?.text ?? "").font(.title)
            Text("H:\(forecastDay?.day?.maxtempC ?? 0.0 , specifier: "%.1f")\u{00B0} L:\( forecastDay?.day?.mintempC ?? 0.0  , specifier: "%.1f")\u{00B0}").font(.title2)
            KFImage(URL(string:"https:\(currentForecast?.condition?.icon ?? "" )")).frame(height: 30)
        }
    }
}

//#Preview {
//    CurrentWeatherForecast()
//}
