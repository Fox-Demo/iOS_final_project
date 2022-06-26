//
//  WeatherData.swift
//  iOS_final_project
//
//  Created by li on 2022/6/19.
//

import Foundation

struct WeatherData: Codable {
    let success: String
    let records: Record
    
    struct Record: Codable{
        let datasetDescription: String
        let location: [Location]

        struct Location: Codable{
            let locationName: String
            let weatherElement: [WeatherElement]
        }
    }
}

struct WeatherElement: Codable{
    let elementName: String
    let time: [Time]
}

struct Time: Codable{
    let startTime: String
    let endTime: String
    let parameter: Parameter
    
    struct Parameter: Codable{
        let parameterName: String
        let parameterUnit: String?
        let parameterValue: String?
    }
}
