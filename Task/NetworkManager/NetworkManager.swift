//
//  NetworkManager.swift
//  Task
//
//  Created by ARK on 11/06/2024.
//
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://api.football-data.org/v4/"
    
    private init() {}

    func request<T: Codable>(_ endpoint: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("API key not found in Info.plist")
            return
        }
        
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(type, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    enum NetworkError: Error {
        case noData
        case invalidResponse
    }
}
