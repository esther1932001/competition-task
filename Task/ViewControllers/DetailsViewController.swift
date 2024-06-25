//
//  DetailsViewController.swift
//  Task
//
//  Created by esterelzek on 09/06/2024.
//
import UIKit
import Network

class DetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var numberOfSessionsLable: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    var competition: CompetationDetails?
    var competitionId: Int?
    var teamId: Int?
    var team: Team?
    var activityIndicator: UIActivityIndicatorView!
    var teams = [Team]()
    private var pathMonitor: NWPathMonitor!
    private var isNetworkConnected = false
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Id : \(String(describing: competitionId))")
        
        setupActivityIndicator()
        setupUI()
        startMonitoringNetwork()
        loadDetailsData()
        loadTeamDetails()
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    // MARK: Setup Functions
    private func setupUI() {
        setupTitleLabel(TitleLabel)
        setupLabel(idLabel)
        setupLabel(nameLable)
        setupLabel(codeLabel)
        setupLabel(numberOfSessionsLable)
        setupLabel(lastUpdateLabel)
        setupCollectionView()
    }
    
    private func startMonitoringNetwork() {
        pathMonitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        pathMonitor.pathUpdateHandler = { [weak self] path in
            print("Network status changed: \(path.status)")
            //self?.isNetworkConnected = path.status == .satisfied
            
            DispatchQueue.main.async {
                self?.loadDetailsData()
            }
        }
        pathMonitor.start(queue: queue)
    }
    
    private func stopMonitoringNetwork() {
        pathMonitor.cancel()
    }
    
    // MARK: Data Loading
    
    private func loadDetailsData() {
        guard let competitionId = competitionId else {
            print("Competition ID is nil")
            return
        }
        
        activityIndicator.startAnimating()
        
        if isNetworkConnected {
            let urlString = "competitions/\(competitionId)"
            print("Fetching details for URL: \(urlString)")
            
            NetworkManager.shared.request(urlString, type: CompetationDetails.self) { [weak self] result in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    switch result {
                    case .success(let competitionDetails):
                        print("Successfully fetched competition details: \(competitionDetails)")
                        self?.competition = competitionDetails
                        self?.updateUI(with: competitionDetails)
                        CoreDataManager.shared.saveCompetitionDetails(details: competitionDetails)
                    case .failure(let error):
                        print("Error fetching competition details: \(error.localizedDescription)")
                        self?.showErrorAlert(message: "Error fetching competition details: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            activityIndicator.stopAnimating()
            if let savedDetails = CoreDataManager.shared.fetchSavedCompetitionDetails(competitionId: competitionId) {
                print("Fetched saved competition details: \(savedDetails)")
                competition = savedDetails
                updateUI(with: savedDetails)
            } else {
                print("No saved competition details found")
                showErrorAlert(message: "No saved competition details found")
            }
        }
    }
    
//        func loadTeamDetails() {
//            guard let teamId = teamId else {
//                print("Team ID is nil")
//                return
//            }
//            activityIndicator.startAnimating()
//
//            let urlString = "competitions/\(teamId)/teams"
//            print("Fetching URL: \(urlString)")
//
//            NetworkManager.shared.request(urlString, type: Posts.self) { [weak self] result in
//                DispatchQueue.main.async {
//                    self?.activityIndicator.stopAnimating()
//
//                    switch result {
//                    case .success(let posts):
//                        guard let team = posts.teams?.first else {
//                            return
//                        }
//                        self?.teams = posts.teams ?? []
//                        self?.team = team
//                        self?.collectionView.reloadData()
//
//                    case .failure(let error):
//                        print("Error fetching team details: \(error.localizedDescription)")
//                        self?.showErrorAlert(message: "Error fetching team details: \(error.localizedDescription)")
//                    }
//                }
//            }
//        }
    private func loadTeamDetails() {
        guard let teamId = teamId else {
            print("Team ID is nil")
            return
        }

        activityIndicator.startAnimating()

        if isNetworkConnected {
            let urlString = "competitions/\(teamId)/teams"
            print("Fetching URLlllll: \(urlString)")

            NetworkManager.shared.request(urlString, type: Posts.self) { [weak self] result in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()

                    switch result {
                    case .success(let posts):
                        if let teams = posts.teams {
                            self?.teams = teams
                            self?.team = teams.first

                            // Save teams to Core Data
                            CoreDataManager.shared.saveTeams(teams: teams, competitionId: teamId)

                            self?.collectionView.reloadData()
                        } else {
                            print("No teams found in the fetched posts")
                            self?.showErrorAlert(message: "No teams found")
                        }

                    case .failure(let error):
                        print("Error fetching team details: \(error.localizedDescription)")
                        self?.showErrorAlert(message: "Error fetching team details: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            activityIndicator.stopAnimating()
            // Fetch saved teams from Core Data
            if let savedTeams = CoreDataManager.shared.fetchSavedTeams(competitionId: teamId) {
                print("Fetched saved teams: \(savedTeams)")
                teams = savedTeams
                team = savedTeams.first
                collectionView.reloadData()
            } else {
                print("No saved teams found")
                showErrorAlert(message: "No saved teams found")
            }
        }

    }
}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Attempting to dequeue cell with identifier: DetailsCollectionViewCell")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell else {
            fatalError("Unable to dequeue DetailsCollectionViewCell")
        }
        
        print("Successfully dequeued cell")
        let team = teams[indexPath.row]
        cell.configure(with: team)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 40
        let cellHeight: CGFloat = 300
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth = collectionView.frame.width - 40
        let leftInset = (collectionView.frame.width - cellWidth) / 2
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: leftInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let competition = competition else {
            return
        }
        let teamId = teams[indexPath.row].id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let teamDetailVC = storyboard.instantiateViewController(withIdentifier: "TeamDetailViewController") as? TeamDetailViewController {
            teamDetailVC.team = teams[indexPath.row]
            navigationController?.pushViewController(teamDetailVC, animated: true)
        }
    }
}

// MARK: - Private Helper Methods
extension DetailsViewController {
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        print("Collection view setup complete and cell registered with identifier: DetailsCollectionViewCell")
    }

    private func updateUI(with competition: CompetationDetails) {
        TitleLabel.text = competition.name ?? "Competition"
        nameLable.text = competition.name ?? "Name: N/A"
        idLabel.text = "Type: \(competition.type ?? "N/A")"
        teamId = competition.id
        codeLabel.text = "Code: \(competition.code ?? "N/A")"
        numberOfSessionsLable.text = "Seasons: \(competition.currentSeason?.currentMatchday ?? 0)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let lastUpdated = competition.lastUpdated {
            let formattedDate = formatter.string(from: lastUpdated)
            lastUpdateLabel.text = "Updated: \(formattedDate)"
            print("Date : \(formattedDate)")
        } else {
            lastUpdateLabel.text = "Updated: N/A"
        }
    }
}
