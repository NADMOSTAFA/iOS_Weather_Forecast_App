//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Apple on 19/05/2024.
//

import Foundation
import CoreLocation

class WeatherForecastViewModel : ObservableObject{
    @Published var weatherData: ApiResponse?
    @Published var error: Error?
    @Published var location: CLLocation?
    
    private var networkService: NetworkServiceProtocol
    private var locationManager: LocationManager
    
    init(networkService: NetworkServiceProtocol = NetworkService.instance) {
        print("enter init")
        self.networkService = networkService
        self.locationManager = LocationManager()
        self.locationManager.onLocationUpdate = { [weak self] location in
            self?.location = location
            print("lat \(location.coordinate.latitude), long \(location.coordinate.longitude)")
            self?.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        self.locationManager.startUpdatingLocation()
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        networkService.fetchData(parameters: ["q":"\(latitude),\(longitude)"]) { [weak self] (result: Result<ApiResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("Data come successfully")
                    self?.weatherData = data
                    self?.weatherData?.forecast?.forecastday = self?.setWeatherForecastTime(forecast: (data.forecast?.forecastday)!)
                    print(self!.weatherData?.location?.region ?? "no")
                    self?.setFilteredWeatherHoures()
                case .failure(let error):
                    self?.error = error
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date Format"
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.isDate(date, inSameDayAs: currentDate) {
            return "Today"
        } else {
            dateFormatter.dateFormat = "EEE"
            return dateFormatter.string(from: date)
        }
    }
    
    func setWeatherForecastTime(forecast : [Forecastday]) -> [Forecastday]{
        var forecastDays = forecast
            for i in 0..<forecastDays.count {
                if var hours = forecastDays[i].hour {
                    for j in 0..<hours.count {
                        hours[j].time = self.convertTo12HourFormat(dateTimeString: hours[j].time ?? "")
                    }
                    forecastDays[i].hour = hours
                }
            }
            return forecastDays
        
    }
    
    func setFilteredWeatherHoures(){
        if var hours = weatherData?.forecast?.forecastday![0].hour {
            for _ in 0..<hours.count {
                hours = self.filterHours(hours)
            }
            print("----------\(hours.count)")
            weatherData?.forecast?.forecastday![0].hour = hours
        }
    }
    
    
    func filterHours(_ hours: [Hour]) -> [Hour] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        // Get the current hour in 24-hour format
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        // Filter the hours array based on the current hour
        let filteredHours = hours.filter { hour in
            guard let hourString = hour.time, let hourDate = dateFormatter.date(from: hourString) else {
                print("Invalid hour format")
                return false
            }
            let hourComponent = Calendar.current.component(.hour, from: hourDate)
            return hourComponent >= currentHour
        }
        return filteredHours
    }
    func isDateEqualToCurrentDate(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let givenDate = dateFormatter.date(from: dateString) else {
            print("Invalid date format")
            return false
        }
        let currentDate = Date()
        return Calendar.current.isDate(currentDate, equalTo: givenDate, toGranularity: .day)
    }
    
    func convertTo12HourFormat(dateTimeString: String) -> String {
        // Create a date formatter for the input date-time string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm" // input format
        
        // Parse the date-time string to a Date object
        guard let date = inputFormatter.date(from: dateTimeString) else {
            return "Invalid Date Format"
        }
        
        // Create a date formatter for the output time string
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a" // output format in 12-hour time with AM/PM
        
        // Format the Date object to a 12-hour time string
        let timeString = outputFormatter.string(from: date)
        
        return timeString
    }
    
}
