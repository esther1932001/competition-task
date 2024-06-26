//
//  TeamCoreDataManager.swift
//  Task
//
//  Created by esterelzek on 24/06/2024.
//
import UIKit
import CoreData

extension CoreDataManager {
    
    func saveTeams(teams: [Team]) {
        let context = self.context()
        for team in teams {
            print("Saving team: \(team)")
            
            if let teamCD = NSEntityDescription.insertNewObject(forEntityName: "TeamCD", into: context) as? TeamCD {
                teamCD.id = Int32(team.id ?? 0)
                teamCD.name = team.name
                teamCD.shortName = team.shortName
                teamCD.crest = team.crest
                teamCD.address = team.address
                teamCD.website = team.website
                teamCD.tla = team.tla
                //                // Save squad members
                //                if let squad = team.squad {
                //                    for squadMember in squad {
                //                        if let squadCD = NSEntityDescription.insertNewObject(forEntityName: "SquadCD", into: context) as? SquadCD {
                //                            squadCD.id = Int32(squadMember.id ?? 0)
                //                            squadCD.name = squadMember.name
                //                            squadCD.position = squadMember.position
                //                            squadCD.dateOfBirth = squadMember.dateOfBirth
                //                            squadCD.nationality = squadMember.nationality
                //                            // Set the relationship back to the team
                //                            squadCD.team = teamCD
                //                            // Add squadCD to teamCD's squad relationship
                //                            teamCD.addToSquad(squadCD)
                //                        }
                //                    }
                //                }
                //
                // Save other attributes as necessary
            } else {
                print("Failed to create a new TeamCD object")
            }
        }
        
        do {
            try context.save()
            print("Teams saved successfully!")
        } catch {
            print("Failed to save teams to Core Data: \(error.localizedDescription)")
        }
    }
    func clearTeams() {
        let context = self.context()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TeamCD.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Failed to clear teams: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Fetch Saved Teams
    func fetchSavedTeams() -> [TeamCD]? {
        let context = self.context()
        let fetchRequest: NSFetchRequest<TeamCD> = TeamCD.fetchRequest()
        
        do {
            let fetchedTeams = try context.fetch(fetchRequest)
            fetchedTeams.forEach { print("Fetched team: \($0)") }
            return fetchedTeams
        } catch {
            print("Failed to fetch teams from Core Data: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Print Saved Teams
    func printSavedTeams() {
        if let savedTeams = fetchSavedTeams() {
            print("Saved Teams:")
            for team in savedTeams {
                print("Team ID: \(team.id), Team Name: \(team.name ?? "N/A"), Team image : \(team.crest ?? "N/A") , Team Short name: \(team.shortName ?? "N/A")")
                // Print other attributes as necessary
            }
        } else {
            print("No teams saved in Core Data.")
        }
    }
    
}
