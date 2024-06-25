//
//  CompetetionDetails.swift
//  Task
//
//  Created by ARK on 10/06/2024.
//

import Foundation

// MARK: - Posts
struct Posts: Codable {
    var count: Int?
    var competitions: [CompetationDetails]?
    var season: Season?
    var teams: [Team]?
    var filters: Filters?
    var competition: Competition?
}

// MARK: - Competition
struct Competition: Codable {
    var id: Int?
    var name, code, type, emblem: String?
}

// MARK: - CompetationDetails
struct CompetationDetails: Codable {
    var area: Area?
    var id: Int?
    var name, code, type: String?
    var emblem: String?
    var currentSeason: Season?
    var lastUpdated: Date?
}

// MARK: - Team
struct Team: Codable {
    var area: Area?
    var id: Int?
    var name, shortName, tla: String?
    var crest: String?
    var address: String?
    var website: String?
    var founded: Int?
    var clubColors, venue: String?
    var runningCompetitions: [CompetationDetails]?
    var coach: Coach?
    var squad: [Squad]?
    var lastUpdated: Date?
   // var competitionId: Int? 
}

// MARK: - Area
struct Area: Codable {
    var id: Int?
    var name: String?
    var code: String?
    var flag: String?
}

// MARK: - Filters
struct Filters: Codable {
    var season: String?
}

// MARK: - Squad
struct Squad: Codable {
    var id: Int?
    var name: String?
    var position: String?
    var dateOfBirth: String?
    var nationality: String?
}

// MARK: - Coach
struct Coach: Codable {
    let id: Int?
    let firstName, lastName, name, dateOfBirth: String?
    let nationality: String?

}

// MARK: - Season
struct Season: Codable {
    var id: Int?
    var startDate, endDate: String?
    var currentMatchday: Int?
    var winner: Winner?
}

// MARK: - Winner
struct Winner: Codable {
    var id: Int?
    var name, shortName, tla: String?
    var crest: String?
    var address: String?
    var website: String?
    var founded: Int?
    var clubColors, venue: String?
    var lastUpdated: Date?
}
