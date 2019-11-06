//
//  TableViewController.swift
//  BIT
//
//  Created by Miska  on 05/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UISearchBarDelegate{
    
    let searchController = UISearchController(searchResultsController: nil)
    let networkDataFetch = DataFetch()
    var githubResponse:GitResponse? = nil
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    private func setupSearchBar(){
        searchController.searchBar.delegate = self
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.backgroundColor = UIColor.blue
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        let urlString = "https://api.github.com/search/repositories?q=\(searchText)+in:name&sort=stars&order=desc"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.networkDataFetch.fetchRepos(urlString: urlString, response: { (gitResponse) in
                guard let gitResponse = gitResponse else {return}
                self.githubResponse = gitResponse
                self.tableView.reloadData()
            })
        })
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return githubResponse?.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gitCell") as! RepoTableViewCell
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let repo = githubResponse?.items?[indexPath.row]
        cell.backgroundColor = UIColor.clear
        
        cell.repoNameLabel.text = repo?.full_name
        
        if let starCount = repo?.stargazers_count {
            cell.starsCountLabel.text = numberFormatter.string(from: NSNumber(value: starCount))
        }
        
        guard (githubResponse?.items!.isEmpty)! else {
            return cell
        }
        return cell
    }
    
}
