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
    var isFetchinNow:Bool = false
    func fetchRepos(urlString:String, response: @escaping (GitResponse?) -> Void){
        guard !self.isFetchinNow else {
           return
         }
        isFetchinNow = true
        print("is fetchin naow")
        networkService.request(urlString: urlString) { (result) in
            switch result{
                
            case .success(let data):
                do{
                    let repos = try JSONDecoder().decode(GitResponse.self, from: data)
                    response(repos)
                    self.isFetchinNow = false
                    print("Fetched")
                }catch let jsonError{
                    print("Decode failed:", jsonError)
                    response(nil)
                }
            case .failure(let error):
                self.isFetchinNow = false
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
}
