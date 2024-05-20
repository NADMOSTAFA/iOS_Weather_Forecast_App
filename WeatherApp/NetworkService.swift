//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Apple on 19/05/2024.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol{
    func fetchData<T: Decodable>(parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService :  NetworkServiceProtocol{
    
    static let instance = NetworkService() // Singleton instance
    let BaseUrl = "https://api.weatherapi.com/v1/forecast.json"
    let apiKey = "?key=fa1413966c2048869b1220846241705&days=3&aqi=no&alerts=no"
       
       private init() {}
       
    func fetchData<T: Decodable>(parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let url = BaseUrl + apiKey
//        let url = "https://api.weatherapi.com/v1/forecast.json?key=fa1413966c2048869b1220846241705&days=3&aqi=no&alerts=no&q=30.25445,31.3424334"
        print(url + "\n")
        if let url = URL(string: url) {
            AF.request(url, parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}

