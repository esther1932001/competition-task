//
//  TeamDetailViewController.swift
//  Task
//
//  Created by ARK on 10/06/2024.
//
import UIKit

class TeamDetailViewController: UIViewController {

    // MARK: OutLets
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamAddressLabel: UILabel!
    @IBOutlet weak var teamWebsiteLabel: UILabel!
    @IBOutlet weak var teamTlaLabel: UILabel!
    @IBOutlet weak var TitleOfTeamPlayersLabel: UILabel!
    @IBOutlet weak var playersTableView: UITableView! 
    
    // MARK: Variable
    var team: Team?
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        setupTitleLabel(TitleOfTeamPlayersLabel)
        setupLabel(teamNameLabel)
        setupLabel(teamAddressLabel)
        setupLabel(teamWebsiteLabel)
        setupLabel(teamTlaLabel)
        setupTableView()
        
        guard let team = team else { return }
        DispatchQueue.main.async {
            self.updateUI(with: team)
        }
    }
    
    // MARK: - setupTable
    private func setupTableView() {
        playersTableView.dataSource = self
        playersTableView.register(UINib(nibName: "TeamsTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamsTableViewCell")
    }

    // MARK: - setupActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
}

// MARK: - UI Setup
extension TeamDetailViewController {
    func updateUI(with team: Team) {
        teamNameLabel.text = team.name ?? ""
        teamAddressLabel.text = "Address: \(team.address ?? "")"
        teamWebsiteLabel.text = "Website: \(team.website ?? "")"
        teamTlaLabel.text = "TLA: \(team.tla ?? "")"
        if let logoUrl = URL(string: team.crest ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: logoUrl), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.teamLogoImageView.image = image
                    }
                }
            }
        }
        playersTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TeamDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.squad?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsTableViewCell", for: indexPath) as! TeamsTableViewCell
        if let player = team?.squad?[indexPath.row] {
            cell.configure(with: player)
        }
        return cell
    }
}
