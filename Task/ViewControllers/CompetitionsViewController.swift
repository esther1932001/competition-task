//
//  ViewController.swift
//  Task
//
//  Created by esterelzek on 09/06/2024.
//

import UIKit

class CompetitionsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var competitions: [CompetationDetails] = []
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel(titleLabel)
        titleLabel.text = "Competitions"
        setupActivityIndicator()
        setupTableView()
        loadAllCompetitions()
        
    }

    // MARK: setupActivityIndicator Function
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    // MARK: Setup Table Function
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CompetitionTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitionCell")
    }

    private func loadAllCompetitions() {
        activityIndicator.startAnimating()
        NetworkManager.shared.request("competitions", type: Posts.self) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                switch result {
                case .success(let posts):
                    self?.competitions = posts.competitions ?? []
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching competitions: \(error.localizedDescription)")
                    self?.showErrorAlert(message: "Error fetching competitions: \(error.localizedDescription)")
                }
            }
        }
    }


}

// MARK: UITableViewDelegate & UITableViewDataSource
extension CompetitionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionCell", for: indexPath) as? CompetitionTableViewCell else {
            return UITableViewCell()
        }
        
        let competition = competitions[indexPath.row]
        cell.configure(with: competition)
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCompetition = competitions[indexPath.row]
        if let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            detailsViewController.competitionId = selectedCompetition.id
            detailsViewController.teamId = selectedCompetition.id
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
