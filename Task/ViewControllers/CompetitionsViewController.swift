//
//  ViewController.swift
//  Task
//
//  Created by esterelzek on 09/06/2024.
//

import UIKit
import Network


class CompetitionsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var competitions: [CompetationDetails] = []
    var activityIndicator: UIActivityIndicatorView!
    private var pathMonitor: NWPathMonitor!
    private var isNetworkConnected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel(titleLabel)
        titleLabel.text = "Competitions"
        setupActivityIndicator()
        setupTableView()
        startMonitoringNetwork()
        loadAllCompetitions()
       
    }

    // MARK: Start Monitoring Network
    private func startMonitoringNetwork() {
        pathMonitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        pathMonitor.pathUpdateHandler = { [weak self] path in
            print("Network status changed: \(path.status)")
            self?.isNetworkConnected = path.status == .satisfied
            
            // Reload competitions data whenever network status changes
            DispatchQueue.main.async {
                self?.loadAllCompetitions()
            }
        }
        pathMonitor.start(queue: queue)
    }

    // MARK: Stop Monitoring Network
    private func stopMonitoringNetwork() {
        pathMonitor.cancel()
    }

    // MARK: Load All Competitions
    private func loadAllCompetitions() {
        activityIndicator.startAnimating()
        
        if isNetworkConnected {
            NetworkManager.shared.request("competitions", type: Posts.self) { [weak self] result in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    switch result {
                    case .success(let posts):
                        if let competitions = posts.competitions {
                            self?.competitions = competitions
                            // Save competitions to Core Data
                            CoreDataManager.shared.saveCompetitions(competitions: competitions)
                            let savedData = CoreDataManager.shared.fetchSavedCompetitions()
                            print("Saved Data: \(savedData)")
                            self?.tableView.reloadData()
                        } else {
                            print("No competitions found")
                            self?.showErrorAlert(message: "No competitions found")
                        }
                    case .failure(let error):
                        print("Error fetching competitions: \(error.localizedDescription)")
                        self?.showErrorAlert(message: "Error fetching competitions: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            self.activityIndicator.stopAnimating()
           // self.showErrorAlert(message: "No network connection. Loading saved competitions.")
            // Load competitions from Core Data
            self.competitions = CoreDataManager.shared.fetchSavedCompetitions()
            print("Saved Data: \( self.competitions)")
            self.tableView.reloadData()
        }
    }

    // MARK: Deinitialization
    deinit {
        stopMonitoringNetwork()
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

// MARK: -Setup Function
extension CompetitionsViewController {
    // MARK: Setup Activity Indicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    // MARK: Setup Table View
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CompetitionTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitionCell")
    }

}
