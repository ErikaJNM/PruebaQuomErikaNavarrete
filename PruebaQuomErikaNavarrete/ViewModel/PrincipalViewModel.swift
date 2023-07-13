//
//  PrincipalViewModel.swift
//  PruebaQuomErikaNavarrete
//
//  Created by MacBookMBA1 on 12/07/23.
//

import Foundation
class PrincipalViewModel{
    
    static func GetAll(_ ts : String, _ apikey : String, _ hash : String, response : @escaping(Root?, Error?) -> Void
    ){
        let urlString = "https://gateway.marvel.com/v1/public/comics?ts=\(ts)&apikey=\(apikey)&hash=\(hash)&format=comic&offset=\(PrincipalController.offset)&limit=20"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, URLResponse, error in
            let hhtpresponse = URLResponse as! HTTPURLResponse
            if hhtpresponse.statusCode == 200{
                if let dataSource = data {
                    let decoder = JSONDecoder()
                    let result = try!
                    decoder.decode(Root.self, from: dataSource)
                    response(result,nil)
                }
                if let errorSource = error {
                    response (nil,errorSource)
                }
            }else{
                print("Error")
            }
        }).resume()
        
    }
    
    static func GetById(_ ts : String, _ apikey : String, _ hash : String,Id: Int, response : @escaping(Root?, Error?) -> Void
    ){
        let urlString = "https://gateway.marvel.com/v1/public/comics/\(Id)?ts=\(ts)&apikey=\(apikey)&hash=\(hash)&type=comic"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, URLResponse, error in
            let hhtpresponse = URLResponse as! HTTPURLResponse
            print(hhtpresponse.statusCode)
            if hhtpresponse.statusCode == 200{
                if let dataSource = data {
                    let decoder = JSONDecoder()
                    let result = try!
                    decoder.decode(Root.self, from: dataSource)
                    response(result,nil)
                }
                if let errorSource = error {
                    response (nil,errorSource)
                }
            }else{
                print("Error")
            }
        }).resume()
    }
}
