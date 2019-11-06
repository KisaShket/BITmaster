//
//  DataFetch.swift
//  BIT
//
//  Created by Miska  on 06/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

import Foundation

class DataFetch{
    let networkService = Net()
    
    func fetchRepos(urlString:String, response: @escaping (GitResponse?) -> Void){
        networkService.request(urlString: urlString) { (result) in
            switch result{
                
            case .success(let data):
                do{
                    let repos = try JSONDecoder().decode(GitResponse.self, from: data)
                    response(repos)
                }catch let jsonError{
                    print("Decode failed:", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
}
