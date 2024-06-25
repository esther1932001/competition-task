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
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel(longNameLabel)
        setupLabel(shortNameLabel)
        setupLabel(code)
        setupLabel(type)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with competition: CompetationDetails) {
        print("Configuring with competition: \(competition)")
        longNameLabel.text = competition.name
        shortNameLabel.text = competition.emblem
        code.text = "code: \(competition.code ?? "")"
        if let typeValue = competition.type {
            type.text = "type: \(typeValue)"
        } else {
            type.text = "Games: N/A"
        }
    }

}
