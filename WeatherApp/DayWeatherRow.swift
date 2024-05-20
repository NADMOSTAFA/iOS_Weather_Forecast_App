//
//  DayWeatherRow.swift
//  WeatherApp
//
//  Created by Apple on 18/05/2024.
//

import SwiftUI
import Kingfisher

struct DayWeatherRow: View {
    var forecastDay : Forecastday
    var day : String
    var body: some View {
        VStack{
            Divider()
                .background(Color.black.frame(height: 1)) .padding(.horizontal,65)
            HStack{
                Text(day).font(.title3).frame(width: 60,alignment: .leading)
                KFImage(URL(string:"https:\(forecastDay.day?.condition?.icon ?? "" )")).resizable().frame(width: 50,height: 50)
                Text("\(forecastDay.day?.maxtempC ?? 0.0, specifier: "%.1f")\u{00B0} -").frame(width: 54,alignment: .leading)
                Text("\(forecastDay.day?.maxtempC ?? 0.0, specifier: "%.1f")\u{00B0}").frame(width: 45,alignment: .leading)
            }.padding(.vertical , -10)
        }.padding(.vertical , -10)
    }

}

//#Preview {
//    DayWeatherRow()
//}
