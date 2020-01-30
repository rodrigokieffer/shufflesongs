//
//  SongTableViewCell.swift
//  ShuffleSongs
//
//  Created by Rodrigo Kieffer on 24/07/19.
//  Copyright © 2019 Rodrigo Kieffer. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    func configure(track: Result?) {
        guard let track = track else { return }
        artistImage.downloaded(from: track.artworkUrl ?? "")
        artistLabel.text = track.artistName ?? ""
        titleLabel.text = track.trackName ?? ""
    }
}
