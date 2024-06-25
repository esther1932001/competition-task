//
//  PostsCoreDataManager.swift
//  Task
//
//  Created by esterelzek on 23/06/2024.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Task")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func context() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Save Competitions
    func saveCompetitions(competitions: [CompetationDetails]) {
        let context = self.context()
        
        // clearCompetitions()
        
        for competition in competitions {
            print("Saving competition: \(competition)")
            
            let competitionCD = CompetationDetailsCD(context: context)
            competitionCD.id = Int32(competition.id ?? 0)
            competitionCD.name = competition.name
            competitionCD.code = competition.code
            competitionCD.type = competition.type
            competitionCD.emblem = competition.emblem
            competitionCD.lastUpdated = competition.lastUpdated
    
//            if let area = competition.area {
//                let areaCD = AreaCD(context: context)
//                areaCD.id = Int32(area.id ?? 0)
//                areaCD.name = area.name
//                areaCD.code = area.code
//                areaCD.flag = area.flag
//                competitionCD.addToArea(areaCD)
//                print("Saving area: \(area)")
//            }
//            
//            if let currentSeason = competition.currentSeason {
//                let seasonCD = SeasonCD(context: context)
//                seasonCD.id = Int32(currentSeason.id ?? 0)
//                seasonCD.startDate = currentSeason.startDate
//                seasonCD.endDate = currentSeason.endDate
//                seasonCD.currentMatchday = Int32(currentSeason.currentMatchday ?? 0)
//                competitionCD.addToCurrentSeason(seasonCD)
////                competitionCD.currentSeason = seasonCD
//                
//                print("Saving current season: \(currentSeason)")
//            }
        }
        
        do {
            try context.save()
            print("Competitions saved successfully!")
        } catch {
            print("Failed to save competitions to Core Data: \(error.localizedDescription)")
        }
    }

    // MARK: - Clear Competitions
    func clearCompetitions() {
        let context = self.context()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CompetationDetailsCD.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Failed to clear competitions: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Fetch Saved Competitions
    func fetchSavedCompetitions() -> [CompetationDetails] {
        let context = self.context()
        let fetchRequest: NSFetchRequest<CompetationDetailsCD> = CompetationDetailsCD.fetchRequest()
        
        do {
            let fetchedCompetitions = try context.fetch(fetchRequest)
            fetchedCompetitions.forEach { print("Fetched competitionCD: \($0)") }
            
            let competitions = fetchedCompetitions.map { competitionCD in
                CompetationDetails(
                    area: competitionCD.area.flatMap { Area(id: Int($0.id), name: $0.name, code: $0.code, flag: $0.flag) },
                    id: Int(competitionCD.id),
                    name: competitionCD.name,
                    code: competitionCD.code,
                    type: competitionCD.type,
                    emblem: competitionCD.emblem,
                    currentSeason: competitionCD.currentSeason.flatMap { Season(id: Int($0.id), startDate: $0.startDate, endDate: $0.endDate, currentMatchday: Int($0.currentMatchday), winner: nil) },
                    lastUpdated: competitionCD.lastUpdated
                )
            }
            
            competitions.forEach { print("Mapped competition: \($0)") }
            return competitions
        } catch {
            print("Failed to fetch competitions from Core Data: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Save Competition Details
    func saveCompetitionDetails(details: CompetationDetails) {
        let context = self.context()
        
        clearCompetitionDetails(competitionId: details.id ?? 0)
        
        let competitionCD : CompetationDetailsCD! = NSEntityDescription.insertNewObject(forEntityName: "CompetationDetailsCD", into: context) as? CompetationDetailsCD
        competitionCD.id = Int32(details.id ?? 0)
        competitionCD.name = details.name
        competitionCD.code = details.code
        competitionCD.type = details.type
        competitionCD.emblem = details.emblem
        competitionCD.lastUpdated = details.lastUpdated
        
        if let area = details.area {
            let areaCD = AreaCD(context: context)
            areaCD.id = Int32(area.id ?? 0)
            areaCD.name = area.name
            areaCD.code = area.code
            areaCD.flag = area.flag
            competitionCD.area = areaCD
        }
        
        if let currentSeason = details.currentSeason {
            let seasonCD = SeasonCD(context: context)
            seasonCD.id = Int32(currentSeason.id ?? 0)
            seasonCD.startDate = currentSeason.startDate
            seasonCD.endDate = currentSeason.endDate
            seasonCD.currentMatchday = Int32(currentSeason.currentMatchday ?? 0)
            competitionCD.currentSeason = seasonCD
        }
        
        do {
            try context.save()
            print("Competition details saved successfully!")
        } catch {
            print("Failed to save competition details to Core Data: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch Saved Competition Details
    func fetchSavedCompetitionDetails(competitionId: Int) -> CompetationDetails? {
        let context = self.context()
        let fetchRequest: NSFetchRequest<CompetationDetailsCD> = CompetationDetailsCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(competitionId))
        
        do {
            if let competitionCD = try context.fetch(fetchRequest).first {
                return CompetationDetails(
                    area: competitionCD.area.flatMap { Area(id: Int($0.id), name: $0.name, code: $0.code, flag: $0.flag) },
                    id: Int(competitionCD.id),
                    name: competitionCD.name,
                    code: competitionCD.code,
                    type: competitionCD.type,
                    emblem: competitionCD.emblem,
                    currentSeason: competitionCD.currentSeason.flatMap { Season(id: Int($0.id), startDate: $0.startDate, endDate: $0.endDate, currentMatchday: Int($0.currentMatchday), winner: nil) },
                    lastUpdated: competitionCD.lastUpdated
                )
            }
        } catch {
            print("Failed to fetch competition details from Core Data: \(error.localizedDescription)")
        }
        
        return nil
    }

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

    // MARK: - Clear Competition Details
    private func clearCompetitionDetails(competitionId: Int) {
        let context = self.context()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CompetationDetailsCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(competitionId))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Failed to clear competition details: \(error), \(error.userInfo)")
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
