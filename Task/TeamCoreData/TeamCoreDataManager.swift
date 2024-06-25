//
//  TeamCoreDataManager.swift
//  Task
//
//  Created by esterelzek on 24/06/2024.
//
import UIKit
import CoreData

extension CoreDataManager {
    
     // MARK: - Save Teams
     func saveTeams(teams: [Team], competitionId: Int) {
         let context = self.context()
         
         clearTeams(competitionId: competitionId)
         
         for team in teams {
             let teamCD = TeamCD(context: context)
             teamCD.id = Int32(team.id ?? 0)
             teamCD.name = team.name
             teamCD.tla = team.tla
             teamCD.shortName = team.shortName
             teamCD.address = team.address
             teamCD.website = team.website
             teamCD.founded = Int32(team.founded ?? 0)
             teamCD.clubColors = team.clubColors
             teamCD.venue = team.venue
             teamCD.lastUpdated = team.lastUpdated
             
             print("Saving team: \(team)")
         }
         
         do {
             try context.save()
             print("Teams saved successfully!")
         } catch {
             print("Failed to save teams to Core Data: \(error.localizedDescription)")
         }
     }

     
     // MARK: - Fetch Saved Teams
     func fetchSavedTeams(competitionId: Int) -> [Team]? {
         let context = self.context()
         let fetchRequest: NSFetchRequest<TeamCD> = TeamCD.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "competitionId == %d", Int32(competitionId))

         
         do {
             let fetchedTeams = try context.fetch(fetchRequest)
             
             return fetchedTeams.map { teamCD in
                 Team(
                     id: Int(teamCD.id),
                     name: teamCD.name,
                     shortName: teamCD.shortName,
                     tla: teamCD.tla,
                     address: teamCD.address,
                     website: teamCD.website,
                     founded: Int(teamCD.founded),
                     clubColors: teamCD.clubColors,
                     venue: teamCD.venue,
                     lastUpdated: teamCD.lastUpdated
                 )
             }
         } catch {
             print("Failed to fetch teams from Core Data: \(error.localizedDescription)")
             return []
         }
     }

     // MARK: - Clear Teams
     private func clearTeams(competitionId: Int) {
         let context = self.context()
         let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TeamCD.fetchRequest()
         fetchRequest.predicate = NSPredicate(format: "competitionId == %d", Int32(competitionId))
         let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
         
         do {
             try context.execute(deleteRequest)
         } catch let error as NSError {
             print("Failed to clear teams: \(error), \(error.userInfo)")
         }
     }
}
