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
    
    // MARK: - configure Function
    func configure(with competition: CompetationDetails) {
            longNameLabel.text = competition.name
        shortNameLabel.text = competition.area?.name
        numberOfTeams.text = "Teams: \(competition.currentSeason?.currentMatchday ?? 0)"
        if let currentGames = competition.currentSeason?.currentMatchday {
                numberOfGames.text = "Games: \(currentGames)"
            } else {
                numberOfGames.text = "Games: N/A"
            }
        }
}
