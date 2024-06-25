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
}
