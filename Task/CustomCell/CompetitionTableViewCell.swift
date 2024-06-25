//
//  CompetitionTableViewCell.swift
//  Task
//
//  Created by esterelzek on 09/06/2024.
//

import UIKit

class CompetitionTableViewCell: UITableViewCell {
    
    // MARK: OutLets
    @IBOutlet weak var longNameLabel: UILabel!
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var numberOfTeams: UILabel!
    @IBOutlet weak var numberOfGames: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel(longNameLabel)
        setupLabel(shortNameLabel)
        setupLabel(numberOfTeams)
        setupLabel(numberOfGames)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with competition: CompetationDetails) {
        print("Configuring with competition: \(competition)")
        longNameLabel.text = competition.name
        shortNameLabel.text = competition.emblem
        numberOfTeams.text = "code: \(competition.code ?? "")"
        if let currentGames = competition.type {
            numberOfGames.text = "type: \(currentGames)"
        } else {
            numberOfGames.text = "Games: N/A"
        }
    }

}
