//
//  APIService.swift
//  WeatherAssignment
//
//  Created by Lovice Sunuwar on 09/05/2023.
//

import Foundation

public class APIService {
    // Static property for the singleton function
    public static let shared = APIService()
    // Enum for error
    public enum APIError: Error {
        case error(_ scriptErrorString: String)
    }
    // Date Decoding startegy is used if we dont get the dates that dont conform to the decoders strategy or key decoding is used if we want to use another strategy, and only use if we need it.
    public func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStrat: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrat: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<T,APIError>) -> Void){
    // Creating a url from the string
        guard let url = URL(string: urlString) else {
            completion(.failure(.error("Error: Invalid URL")))
            return
        }
    // creating the request from the URL
    
        let request = URLRequest(url: url)
    // we are passing the request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            // checking if the data we got is valid
             guard let data = data else {
                    completion(.failure(.error("Error: Data is corrupt.")))
                 return
             }
            // Creating a decocder
            let decoder = JSONDecoder()
            do {
                // here we are trying to decode the data as per the type
                let decodedData = try decoder.decode(T.self, from: data)
                // associating the decoded data to the type
                completion(.success(decodedData))
                return
            } catch {
                print(String(describing: error))
//                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                }
        }.resume() // Inorder to execute the singleton function.
    }
}


