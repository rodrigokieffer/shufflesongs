//
//  SongsViewModel.swift
//  ShuffleSongs
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import Foundation

protocol SongsDelegate: class {
    func success(_ results: [Result])
    func fail(message: String)
    func shuffled(_ songs: [Result])
}

protocol Service {
    func songs(ids: [String], limit: Int, completionHandler:@escaping( (Data?, URLResponse?, Error?) -> Void ))
}

class SongsViewModel {
    private var acceptableStatusCodes: [Int] { return Array(200..<300) }
    weak var delegate: SongsDelegate?
    private var shuffledResult: [Result] = []
    private var resetShuffledResult = true
    private var service: Service
    
    init(s: Service) {
        service = s
    }
    
    func songs(ids: [String], limit: Int = 5) {
        service.songs(ids: ids, limit: 5) { [unowned self] (data, response, error) in
            guard error == nil else {
                self.delegate?.fail(message: "An error occurs when get songs")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !self.acceptableStatusCodes.contains(httpResponse.statusCode) {
                self.delegate?.fail(message: "An error occurs when get Songs, HTTP Status code: \(httpResponse.statusCode)")
                return
            }
            
            do {
                let songsResponse = try JSONDecoder().decode(SongsResponse.self, from: data!)
                let filtered = self.filterResult(results: songsResponse.results)
                self.delegate?.success(filtered)
            } catch {
                self.delegate?.fail(message: "An error occurs when decode songs response")
            }
        }
    }
    
    func shuffleSongs(songs: [Result]) {
        guard songs.count > 0 else {
            resetShuffledResult = true
            delegate?.shuffled(shuffledResult)
            return
        }
        
        if resetShuffledResult {
            shuffledResult.removeAll()
            resetShuffledResult = false
        }
        
        var songsCopy = songs
        let last = shuffledResult.last
        let index = Int(arc4random_uniform(UInt32(songs.count)))
        let random = songs[index]
        
        if (random.artistId != last?.artistId) {
            shuffledResult.append(random)
            songsCopy.remove(at: index)
        }
        
        shuffleSongs(songs: songsCopy)
    }
    
    // MARK: - Privates
    
    private func filterResult(results: [Result]) -> [Result] {
        let filtered = results.filter { return $0.wrapperType?.lowercased() == "track" }
        return filtered
    }
}
