//
//  DetailsCollectionViewCell.swift
//  Task
//
//  Created by esterelzek on 09/06/2024.
//

import UIKit
import SwiftSVG

class DetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: OutLets
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var longName: UILabel!
    @IBOutlet weak var shortName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel(longName)
        setupLabel(shortName)
    }
    
    // MARK: - Configure Function
    func configure(with team: Team) {
        longName.text = team.name
        shortName.text = team.shortName ?? "No Short Name Available"
        teamImage.image = nil
        teamImage.subviews.forEach { $0.removeFromSuperview() }
        if let urlString = team.crest, let url = URL(string: urlString) {
            print("URL string: \(urlString)")
            downloadSVGImage(from: url)
        } else {
            teamImage.image = UIImage(named: "competitions")
        }
    }
    // MARK: - downloadSVGImage Function
    private func downloadSVGImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let data = try? Data(contentsOf: url), let svgImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.teamImage.image = svgImage
                }
            } else {
                DispatchQueue.main.async {
                    self.teamImage.image = UIImage(named: "competitions")
                }
            }
        }
    }

}
