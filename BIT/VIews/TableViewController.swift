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

   
    let searchController = UISearchController(searchResultsController: nil)
    let networkDataFetch = DataFetch()
    //бесконечный скролл
    var githubResponse:[Repos] = []
    var displayGitResponse:[Repos] = []
    var allReposFetched = false
    var showLoadingCell = false
    var dataFetch = DataFetch()
    
    let numberFormatter = NumberFormatter()
    var latitude:Double = 0
    var longitude:Double = 0
    var currentPage = 1
    var searchTextVar:String = ""
    @objc var starsCount:String = ""

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchNavBar()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    //MARK:-Установка поисковой строки
    private func setupSearchNavBar(){
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        
    }
    
    //MARK:-работа с серчбаром
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard (searchText.count > 0) else {
            showLoadingCell = false
            resetDisplayedRepos()
            return
        }
        
        print(searchText)
        searchTextVar = searchText
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard (searchTextVar.count>0) else{
            return
        }
        
        refreshRepos()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    //MARK:-Настройка ячеек TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = displayGitResponse.count
        //если есть еще записи - показывать дополнительную ячуйки с актив. индикатором
        return showLoadingCell ? count+1 : count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ячейка с активити индикатором
        if isLoadingIndexPath(indexPath){
            return LoadingViewCell(style: .default, reuseIdentifier: "loadingCell")
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "gitCell") as! RepoTableViewCell
            
            numberFormatter.numberStyle = .decimal
            cell.frame = cell.frame.offsetBy(dx: 10, dy: 10)
            //Решаем проблему с индексами
            guard !displayGitResponse.isEmpty else {
                return cell
            }
            let repo = displayGitResponse[indexPath.row]
            cell.backgroundColor = UIColor.clear
            cell.cellDelegate = self
            cell.index = indexPath
            cell.repoNameLabel.text = repo.full_name
            cell.starsCountLabel.text = numberFormatter.string(from: NSNumber(value: repo.stargazers_count))
            return cell
        }
    }
    //MARK:-бесконечный скролл
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.height
        if bottomEdge >= scrollView.contentSize.height {
            print("Reched Bottom")
            currentPage += 1
            getRepos(currentPage: currentPage, searchTextVar: searchTextVar)
        }
    }
    
    //перезагрузка репозиториев
    private func refreshRepos(){
        displayGitResponse.removeAll()
        currentPage = 1
        allReposFetched = false
        getRepos(currentPage: currentPage, searchTextVar: searchTextVar)
    }
    //очистка отображаемых репозиториев
    private func resetDisplayedRepos() {
        displayGitResponse.removeAll()
        currentPage = 1
        tableView.reloadData()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
           guard showLoadingCell else { return false }
           return indexPath.row == self.displayGitResponse.count
       }
    
    //MARK:- ф-я получения репозиториев
    func getRepos(currentPage: Int, searchTextVar: String){
        guard !dataFetch.isFetchinNow && !allReposFetched else{
            return
        }
        let urlString = "https://api.github.com/search/repositories?q=\(searchTextVar)+in:name&sort=stars&order=desc&page=\(currentPage)&per_page=30"
        print(self.currentPage)
        self.networkDataFetch.fetchRepos(urlString: urlString, response: { (gitResponse) in
            guard let gitResponse = gitResponse else {
                return}
            self.allReposFetched = gitResponse.items.isEmpty
            self.displayGitResponse.append(contentsOf: gitResponse.items)
            self.githubResponse = gitResponse.items
            
            self.showLoadingCell = true
            self.showLoadingCell = !gitResponse.items.isEmpty
            self.tableView.reloadData()
            
        })
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
    
    @IBAction func tapped(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
    
}
//MARK:-Нажатие на кнопку, выполнение перехода, записи временных данных
extension TableViewController: cellNew{
    func onClickCell(index: IndexPath) {
        searchBar.resignFirstResponder()
        let strcnt = displayGitResponse[index.row]
        starsCount = numberFormatter.string(from: NSNumber(value: strcnt.stargazers_count))!
        latitude = randomBetween(-90, 90)
        longitude = randomBetween(-180, 180)
        performSegue(withIdentifier: "toTheMap", sender: nil)
    }
}

