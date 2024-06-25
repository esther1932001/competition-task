//
//  TeamCoreDataManager.swift
//  Task
//
//  Created by esterelzek on 24/06/2024.
//
import UIKit
import CoreData

//extension CoreDataManager {
//    
//    func saveTeams(teams: [Team]) {
//        let context = self.context()
//        
//        clearTeams()
//        
//        for team in teams {
//            print("Saving team: \(team)")
//            
//            let teamCD = TeamCD(context: context)
//            teamCD.id = Int32(team.id ?? 0)
//            teamCD.name = team.name
//            teamCD.shortName = team.shortName
//            teamCD.tla = team.tla
//            teamCD.crest = team.crest
//            teamCD.address = team.address
//            teamCD.website = team.website
//            teamCD.founded = Int32(team.founded ?? 0)
//            teamCD.clubColors = team.clubColors
//            teamCD.venue = team.venue
//            teamCD.lastUpdated = team.lastUpdated
//            
//            // Save coach
//            if let coach = team.coach {
//                let coachCD = CoachCD(context: context)
//                coachCD.id = Int32(coach.id ?? 0)
//                coachCD.name = coach.name
//                teamCD.coach = coachCD
//                print("Saving coach: \(coach)")
//            }
//            
//            // Save running competitions
//            if let competitions = team.runningCompetitions {
//                for competition in competitions {
//                    let competitionCD = CompetitionCD(context: context)
//                    competitionCD.id = Int32(competition.id ?? 0)
//                    competitionCD.name = competition.name
//                    competitionCD.code = competition.code
//                    teamCD.addToRunningCompetitions(competitionCD)
//                    print("Saving competition: \(competition)")
//                }
//            }
//        }
//        
//        do {
//            try context.save()
//            print("Teams saved successfully!")
//        } catch {
//            print("Failed to save teams to Core Data: \(error.localizedDescription)")
//        }
//    }
//
//    // MARK: - Clear Teams
//    func clearTeams() {
//        let context = self.context()
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TeamCD.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//        do {
//            try context.execute(deleteRequest)
//        } catch let error as NSError {
//            print("Failed to clear teams: \(error), \(error.userInfo)")
//        }
//    }
//    
//    func fetchSavedTeams() -> [Team] {
//        let context = self.context()
//        let fetchRequest: NSFetchRequest<TeamCD> = TeamCD.fetchRequest()
//        
//        do {
//            let fetchedTeams = try context.fetch(fetchRequest)
//            fetchedTeams.forEach { print("Fetched teamCD: \($0)") }
//            
//            let teams = fetchedTeams.map { teamCD in
//                Team(
//                    id: Int(teamCD.id),
//                    name: teamCD.name,
//                    shortName: teamCD.shortName,
//                    tla: teamCD.tla,
//                    crest: teamCD.crest,
//                    address: teamCD.address,
//                    website: teamCD.website,
//                    founded: Int(teamCD.founded),
//                    clubColors: teamCD.clubColors,
//                    venue: teamCD.venue,
//                    runningCompetitions: (teamCD.runningCompetitions?.allObjects as? [CompetitionCD] ?? []).compactMap { competitionCD in
//                        CompetationDetails(
//                            area: nil, // You can add area if available in CompetationDetails struct
//                            id: Int(competitionCD.id),
//                            name: competitionCD.name,
//                            code: competitionCD.code,
//                            type: nil, // Add type if available in CompetationDetails struct
//                            emblem: nil, // Add emblem if available in CompetationDetails struct
//                            currentSeason: nil, // Add currentSeason if available in CompetationDetails struct
//                            lastUpdated: nil // Add lastUpdated if available in CompetationDetails struct
//                        )
//                    },
//                    coach: nil, // No coach information since CoachCD is not available
//                    squad: nil, // No squad information since PlayerCD is not available
//                    lastUpdated: teamCD.lastUpdated
//                )
//            }
//            
//            teams.forEach { print("Mapped team: \($0)") }
//            return teams
//        } catch {
//            print("Failed to fetch teams from Core Data: \(error.localizedDescription)")
//            return []
//        }
//    }
//
//
//}
