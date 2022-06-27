//
//  tdx.swift
//  finalProject
//
//  Created by 林聖祐 on 2022/6/25.
//

import Foundation
import MapKit
import SwiftUI

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
                print("Failed to read JSON Object.")
                return
        }
        print(prettyJSONString)
    }
}

struct BusRouteStops: Codable {
    let routeUID, routeID: String?
    let routeName: Name?
    let direction: Int?
    let stops: [Stop?]
    let updateTime: String?
    let versionID: Int?

    enum CodingKeys: String, CodingKey {
        case routeUID = "RouteUID"
        case routeID = "RouteID"
        case routeName = "RouteName"
        case direction = "Direction"
        case stops = "Stops"
        case updateTime = "UpdateTime"
        case versionID = "VersionID"
    }
}

struct Stop: Codable {
    let stopUID, stopID: String?
    let stopName: Name?
    let stopBoarding, stopSequence: Int?
    let stopPosition: StopPosition?
    let stationID: String?

    enum CodingKeys: String, CodingKey {
        case stopUID = "StopUID"
        case stopID = "StopID"
        case stopName = "StopName"
        case stopBoarding = "StopBoarding"
        case stopSequence = "StopSequence"
        case stopPosition = "StopPosition"
        case stationID = "StationID"
    }
}

struct StopPosition: Codable {
    let positionLon, positionLat: Double?
    let geoHash: String?

    enum CodingKeys: String, CodingKey {
        case positionLon = "PositionLon"
        case positionLat = "PositionLat"
        case geoHash = "GeoHash"
    }
}

struct BusRoute: Codable {
    let routeUID, routeID: String?
    let hasSubRoutes: Bool?
    let operators: [Operator?]
    let authorityID, providerID: String?
    let subRoutes: [SubRoute?]
    let busRouteType: Int?
    let routeName: Name?
    let departureStopNameZh, departureStopNameEn, destinationStopNameZh, destinationStopNameEn: String?
    let ticketPriceDescriptionZh: String?
    let ticketPriceDescriptionEn: String?
    let routeMapImageURL: String?
    let city: String?
    let cityCode: String?
    let updateTime: String?
    let versionID: Int?
    let fareBufferZoneDescriptionZh, fareBufferZoneDescriptionEn: String?

    enum CodingKeys: String, CodingKey {
        case routeUID = "RouteUID"
        case routeID = "RouteID"
        case hasSubRoutes = "HasSubRoutes"
        case operators = "Operators"
        case authorityID = "AuthorityID"
        case providerID = "ProviderID"
        case subRoutes = "SubRoutes"
        case busRouteType = "BusRouteType"
        case routeName = "RouteName"
        case departureStopNameZh = "DepartureStopNameZh"
        case departureStopNameEn = "DepartureStopNameEn"
        case destinationStopNameZh = "DestinationStopNameZh"
        case destinationStopNameEn = "DestinationStopNameEn"
        case ticketPriceDescriptionZh = "TicketPriceDescriptionZh"
        case ticketPriceDescriptionEn = "TicketPriceDescriptionEn"
        case routeMapImageURL = "RouteMapImageUrl"
        case city = "City"
        case cityCode = "CityCode"
        case updateTime = "UpdateTime"
        case versionID = "VersionID"
        case fareBufferZoneDescriptionZh = "FareBufferZoneDescriptionZh"
        case fareBufferZoneDescriptionEn = "FareBufferZoneDescriptionEn"
    }
}

struct Operator: Codable {
    let operatorID: String?
    let operatorName: Name?
    let operatorCode: String?
    let operatorNo: String?

    enum CodingKeys: String, CodingKey {
        case operatorID = "OperatorID"
        case operatorName = "OperatorName"
        case operatorCode = "OperatorCode"
        case operatorNo = "OperatorNo"
    }
}



struct SubRoute: Codable {
    let subRouteUID, subRouteID: String?
    let operatorIDs: [String?]
    let subRouteName: Name?
    let direction: Int?
    let firstBusTime, lastBusTime: String?
    let holidayFirstBusTime, holidayLastBusTime: String?

    enum CodingKeys: String, CodingKey {
        case subRouteUID = "SubRouteUID"
        case subRouteID = "SubRouteID"
        case operatorIDs = "OperatorIDs"
        case subRouteName = "SubRouteName"
        case direction = "Direction"
        case firstBusTime = "FirstBusTime"
        case lastBusTime = "LastBusTime"
        case holidayFirstBusTime = "HolidayFirstBusTime"
        case holidayLastBusTime = "HolidayLastBusTime"
    }
}



struct BusEstimatedTimeOfArrival: Codable {
    let stopUID, stopID: String?
    let stopName: Name?
    let routeUID: String?
    let routeID: String?
    let routeName: Name?
    let direction, estimateTime, stopStatus: Int?
    let srcUpdateTime, updateTime: String?

    enum CodingKeys: String, CodingKey {
        case stopUID = "StopUID"
        case stopID = "StopID"
        case stopName = "StopName"
        case routeUID = "RouteUID"
        case routeID = "RouteID"
        case routeName = "RouteName"
        case direction = "Direction"
        case estimateTime = "EstimateTime"
        case stopStatus = "StopStatus"
        case srcUpdateTime = "SrcUpdateTime"
        case updateTime = "UpdateTime"
    }
}

struct Name: Codable {
    let zhTw, en: String

    enum CodingKeys: String, CodingKey {
        case zhTw = "Zh_tw"
        case en = "En"
    }
}

struct BusEstimatedTimeOfArrivalByRoute: Codable {
    let stopUID, stopID: String?
    let stopName: Name?
    let routeUID: String?
    let routeID: String?
    let routeName: Name?
    let direction: Int?
    let estimateTime: Int?
    let stopStatus: Int?
    let srcUpdateTime, updateTime: String?

    enum CodingKeys: String, CodingKey {
        case stopUID = "StopUID"
        case stopID = "StopID"
        case stopName = "StopName"
        case routeUID = "RouteUID"
        case routeID = "RouteID"
        case routeName = "RouteName"
        case direction = "Direction"
        case estimateTime = "EstimateTime"
        case stopStatus = "StopStatus"
        case srcUpdateTime = "SrcUpdateTime"
        case updateTime = "UpdateTime"
    }
}

struct BusStopNearBy: Codable, Identifiable{
    let id: String?
    let stopName: Name?
    let stopPosition: Position?
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: stopPosition?.PositionLat ?? 0, longitude: stopPosition?.PositionLon ?? 0)
    }
    var distance: CLLocation{
        CLLocation(latitude: stopPosition?.PositionLat ?? 0, longitude: stopPosition?.PositionLon ?? 0)
    }
    
    struct Name: Codable{
        let Zh_tw: String?
        let En: String?
    }
    
    struct Position: Codable{
        let PositionLon: Double?
        let PositionLat: Double?
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "StopUID"
        case stopName = "StopName"
        case stopPosition = "StopPosition"
    }
}

class tdxAPI{
    private let clientId = "t108590008-139f0ce0-30bf-4e4f"
    private let clientSecret = "c939b2e7-ce16-40ef-a9a9-75d50c071c17"
    private let prefix = "https://tdx.transportdata.tw/api/basic"
    private let prefixAdvanced = "https://tdx.transportdata.tw/api/advanced"
    var accessToken:String? = ""
    
    private func generateAccessToken(){
        let sem = DispatchSemaphore(value: 0)
        let url = URL(string: "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token")!

        var request = URLRequest(url: url)
        var data = URLComponents()
        data.queryItems = [
            URLQueryItem(name: "grant_type", value: "client_credentials"),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret)
        ]
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = data.query?.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        self.accessToken = json["access_token"] as? String
                        sem.signal()
                    }
                } catch let error as NSError {
                    print(String(describing: error))
                }

            }
        }.resume()
        sem.wait()
        
    }
    
    func getBusEstimatedTimeOfArrival (city: String, top: Int, completion: @escaping ([BusEstimatedTimeOfArrival])->Void){
        var urlComponent = URLComponents(string: "\(self.prefix)/v2/Bus/EstimatedTimeOfArrival/City/\(city)")!
        urlComponent.queryItems = [
            URLQueryItem(name: "$top", value: String(top)),
            URLQueryItem(name: "$format", value: "JSON")
        ]
        
        let request = basicRequest(url: urlComponent.url!)
        let json:[BusEstimatedTimeOfArrival] = parseJson(request: request)
        completion(json)
    }
    
    func getBusEstimatedTimeOfArrivalByRoute (city: String, routeName: String, top: Int, completion: @escaping ([BusEstimatedTimeOfArrivalByRoute])->Void){
        var urlComponent = URLComponents(string: "\(self.prefix)/v2/Bus/EstimatedTimeOfArrival/City/\(city)/\(routeName)")!
        urlComponent.queryItems = [
            URLQueryItem(name: "$top", value: String(top)),
            URLQueryItem(name: "$format", value: "JSON")
        ]
        
        let request = basicRequest(url: urlComponent.url!)
        let json:[BusEstimatedTimeOfArrivalByRoute] = parseJson(request: request)
        completion(json)
    }
    
    func getBusRouteByCity(city: String) -> [BusRoute]{
        var urlComponent = URLComponents(string: "\(self.prefix)/v2/Bus/Route/City/\(city)")!
        urlComponent.queryItems = [
            URLQueryItem(name: "$format", value: "JSON")
        ]
        
        let request = basicRequest(url: urlComponent.url!)
        let json:[BusRoute] = parseJson(request: request)
        
        return json
    }
    
    func getBusStopNearBy(latitude: Double, longitude: Double, top: Int, completion: @escaping ([BusStopNearBy])->Void){
        var urlComponent = URLComponents(string: "\(self.prefixAdvanced)/v2/Bus/Stop/NearBy")!
        urlComponent.queryItems = [
            URLQueryItem(name: "$top", value: String(top)),
            URLQueryItem(name: "$spatialFilter", value: "nearby(\(String(latitude)), \(String(longitude)), 1000)"),
            URLQueryItem(name: "$format", value: "JSON")
        ]
        
        let request = basicRequest(url: urlComponent.url!)
        let json:[BusStopNearBy] = parseJson(request: request)
        completion(json)
    }
    
    func getBusStopsByRoute(city: String, route: String, direction: Int) -> BusRouteStops?{
        var urlComponent = URLComponents(string: "\(self.prefix)/v2/Bus/DisplayStopOfRoute/City/\(city)/\(route)")!
        urlComponent.queryItems = [
            URLQueryItem(name: "$format", value: "JSON")
        ]
        
        let request = basicRequest(url: urlComponent.url!)
        let json:[BusRouteStops] = parseJson(request: request)
        
        let filterJson = json.filter({$0.direction == direction})
        if filterJson.count > 0 {
            return filterJson[0]
        }
        return nil
    }
    
    func getBusEstimatedTimeOfArrivalByRoute (city: String, routeName: String, completion: @escaping ([BusEstimatedTimeOfArrivalByRoute])->Void){
        var urlComponent = URLComponents(string: "\(self.prefix)/v2/Bus/EstimatedTimeOfArrival/City/\(city)/\(routeName)")!
        urlComponent.queryItems = [
            
            URLQueryItem(name: "$format", value: "JSON")
        ]
        
        let request = basicRequest(url: urlComponent.url!)
        let json:[BusEstimatedTimeOfArrivalByRoute] = parseJson(request: request)
        completion(json)
    }
    
    private func basicRequest(url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        if(self.accessToken == ""){
            self.generateAccessToken();
        }
        request.setValue("Bearer \(self.accessToken!)", forHTTPHeaderField: "authorization")
        request.httpMethod = "GET"
         
        return request
    }
    
    private func parseJson<T: Decodable>(request: URLRequest) -> T {
        let sem = DispatchSemaphore(value: 0)
        var json:T? = nil
        URLSession.shared.dataTask(with: request) { data, response, error in

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseJson = try decoder.decode(T.self, from: data)
                    json = responseJson
                    sem.signal()
                } catch let error as NSError {
                    print(String(describing: error))
                }
            }
        }.resume()
        sem.wait()
        return json!
    }
}
