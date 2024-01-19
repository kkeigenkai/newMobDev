//
//  Network.swift
//  mob_dev
//
//  Created by Sergei Pshonnov on 06.01.2024.
//

import SwiftUI

class Network: ObservableObject {
    @Published var pictureOfTheDay = PictureOfTheDay(
        date: "",
        url: "",
        title: "",
        explanation: "")
    @Published var searchResult = NewEmptyNasaSearch()
    
    func getNasaSearch(query: String) {
        let baseURL = "https://images-api.nasa.gov"
        guard let url =
                URL(string: "\(baseURL)/search?q=\(query)&media_type=image")
        else {
            fatalError("Missing request URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {return}
                DispatchQueue.main.async {
                    do {
                        let decodedSearch = try JSONDecoder().decode(NasaSearch.self, from: data)
                        self.searchResult = decodedSearch
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    func getPicktureOfTheDay(day: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let baseURL = "https://api.nasa.gov"
        let apiKey = "QENM2TIRsYGnfHepVNFDJNpbukhBzTXB1ex8Eh73"
        let path = "planetary/apod"
        let date = formatter.string(from: day)
        
        guard let url =
                URL(string:"\(baseURL)/\(path)?api_key=\(apiKey)&date=\(date)")
        else {
            fatalError("Missing request URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {return}
                DispatchQueue.main.async {
                    do {
                        let decodedcPicture = try JSONDecoder().decode(PictureOfTheDay.self, from: data)
                        self.pictureOfTheDay = decodedcPicture
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
