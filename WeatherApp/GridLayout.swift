//
//  GridLayout.swift
//  WeatherApp
//
//  Created by Apple on 18/05/2024.
//

import SwiftUI


struct GridLayout: View {
     var currentWeather : Current?
    // Define the grid layout with two columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        // Use LazyVGrid to create a vertical grid
        LazyVGrid(columns: columns) {
                VStack{
                    Text("VISIBILITY")
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .overlay(
                            Text(String(currentWeather?.visKM ?? 0.0) + "km")
                                .foregroundColor(.black)
                                .font(.title)
                        ).padding(.bottom,30)
                    
                }
            VStack{
                Text("HUMIDITY")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                Rectangle()
                    .fill(Color.clear)
                    .overlay(
                        Text(String(currentWeather?.humidity ?? 0.0) + "%")
                            .foregroundColor(.black)
                            .font(.title)
                    ).padding(.bottom,30)
                
            }
            VStack{
                Text("FEELSLIKE")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                Rectangle()
                    .fill(Color.clear)
                    .overlay(
                        Text(String(currentWeather?.feelslikeC ?? 0.0) + "\u{00B0}")
                            .foregroundColor(.black)
                            .font(.title)
                    ).padding(.bottom,30)
                
            }
            VStack{
                Text("PRESSURE")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                Rectangle()
                    .fill(Color.clear)
                    .overlay(
                        Text(String(currentWeather?.pressureMB ?? 0.0))
                            .foregroundColor(.black)
                            .font(.title)
                    ).padding(.bottom,30)
                
            }
            
        }.padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
    }
}

//#Preview {
//    GridLayout()
//}
