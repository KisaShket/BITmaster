//
//  TableViewController.swift
//  BIT
//
//  Created by Miska  on 05/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

import UIKit
import GoogleMaps
@objc class TableViewController: UITableViewController,UISearchBarDelegate{
    @objc var starsCount:String = ""
    let searchController = UISearchController(searchResultsController: nil)
    let networkDataFetch = DataFetch()
    var githubResponse:GitResponse? = nil
    let numberFormatter = NumberFormatter()
    var latitude:Double = 0
    var longitude:Double = 0
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    //MARK:-Установка поисковой строки
    private func setupSearchBar(){
        searchController.searchBar.delegate = self
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.backgroundColor = UIColor.blue
    }
    
    //MARK:-Создание/реализация URL запроса
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
    
    //MARK:-Настройка ячеек TableView
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubResponse?.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gitCell") as! RepoTableViewCell
        numberFormatter.numberStyle = .decimal
        let repo = githubResponse?.items?[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.cellDelegate = self
        cell.index = indexPath
        cell.repoNameLabel.text = repo?.full_name
        
        if let starCount = repo?.stargazers_count {
            cell.starsCountLabel.text = numberFormatter.string(from: NSNumber(value: starCount))
        }
        
        guard (githubResponse?.items!.isEmpty)! else {
            return cell
        }
        return cell
    }
   //MARK:-Рандомайзер
    func randomBetween(_ firstNum: Double, _ secondNum: Double) -> Double{
        return Double(arc4random()) / Double(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    //MARK:-Передача данных на карту
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTheMap"{
           let toMap = segue.destination as! MapViewController
            toMap.starsCOUNT = starsCount
            let subLatitude = String(format: "%.2f", latitude)
            let subLongitude = String(format: "%.2f", longitude)
            toMap.latit = subLatitude
            toMap.longit = subLongitude
            print(toMap.latit, toMap.longit)
        }
    }
}
//MARK:-Нажатие на кнопку, выполнение перехода, записи временных данных
extension TableViewController: cellNew{
    func onClickCell(index: IndexPath) {
        let strcnt = githubResponse?.items![index.row]
        starsCount = numberFormatter.string(from: NSNumber(value: strcnt!.stargazers_count!))!
        latitude = randomBetween(-90, 90)
        longitude = randomBetween(-180, 180)
        performSegue(withIdentifier: "toTheMap", sender: nil)
    }
}
