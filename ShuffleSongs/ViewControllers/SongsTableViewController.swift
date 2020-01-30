//
//  SongsTableViewController.swift
//  ShuffleSongs
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import UIKit

class SongsTableViewController: UITableViewController {

    private let cellIdentifier = "SongCellIdentifier"
    private var model: SongsViewModel?
    private var results: [Result]?
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        fetchSongs()
    }

    // MARK: - Privates
    
    private func setup() {
        self.tableView.tableFooterView = UIView(frame: .zero)
        model = SongsViewModel(s: SongsService())
        model?.delegate = self
    }
    
    private func fetchSongs() {
        let ids = ["909253", "1171421960", "358714030", "1419227", "264111789"]
        
        RKLoading.showLoading(in: self.view)
        model?.songs(ids: ids)
    }
    
    // MARK: - Selectors
    
    @IBAction func shuffle() {
        let sortedSongs = results?.sorted { return $0.artistId == $1.artistId }
        model?.shuffleSongs(songs: sortedSongs ?? [])
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SongTableViewCell

        let track = results?[indexPath.row]
        cell.configure(track: track)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension SongsTableViewController: SongsDelegate {
    func success(_ results: [Result]) {
        RKLoading.hideLoading()
        DispatchQueue.main.async { [weak self] in
            self?.results = results
            self?.tableView.reloadData()
        }
    }
    
    func fail(message: String) {
        RKLoading.hideLoading()
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func shuffled(_ songs: [Result]) {
        DispatchQueue.main.async { [weak self] in
            self?.results = songs
            self?.tableView.reloadData()
        }
    }
}
