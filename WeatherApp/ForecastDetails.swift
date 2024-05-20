//
//  ForecastDetails.swift
//  WeatherApp
//
//  Created by Apple on 18/05/2024.
//

import SwiftUI
import Kingfisher

struct ForecastDetails: View {
    var forecastDay : Forecastday

    var body: some View {
        VStack{
            List(forecastDay.hour!, id: \.time){ hour in
                HStack{
                    Text(hour.time!).font(.title)
                    Spacer()
                    KFImage(URL(string:"https:\(hour.condition?.icon ?? "" )")).resizable().frame(width: 50,height: 50)
                    //Image(.icon).resizable().frame(width: 60,height: 60)
                    Spacer()
                    Text(String(hour.tempC!)).font(.title)
                }.padding(.horizontal,30).listRowBackground(Color.clear)
            } .listStyle(PlainListStyle())
                .background(Color.clear)
            Spacer()
        }.background(Image(.day))
    }
}

//#Preview {
//    ForecastDetails()
//}
