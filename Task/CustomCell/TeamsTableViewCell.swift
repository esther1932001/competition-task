//
//  TeamsTableViewCell.swift
//  Task
//
//  Created by ARK on 10/06/2024.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {

    // MARK: OutLets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel(nameLabel)
        setupLabel(positionLabel)
        setupLabel(nationalityLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
       // MARK: - Configure Function
        func configure(with player: Squad) {
            nameLabel.text = "Name: \(player.name ?? "N/A")"
            positionLabel.text = "Position: \(player.position ?? "N/A")"
            nationalityLabel.text = "Nationality: \(player.nationality ?? "N/A")"
        }
}
