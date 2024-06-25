//
//  CompetitionDetailsDataManager.swift
//  Task
//
//  Created by esterelzek on 25/06/2024.
//

import Foundation
import CoreData
extension CoreDataManager {
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


}
