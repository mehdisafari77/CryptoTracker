//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Mehdi MMS on 14/03/2022.
//

import Foundation
import Combine

class NetworkManager {
    
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⛔️] Unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            // as by default subscribe to background thread
            // so no need to explicitly write it, we can comment it.
            //.subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            // as we move the decode task also onto background thread then after that move to foreground thread
            // instead of writing here, mention after decode modifier
            //.receive(on: DispatchQueue.main)
            .retry(3) // if it fails, it will repeat for 3 times, in order to get good data.
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error in getting coins data: ", error.localizedDescription)
        }
    }
}
