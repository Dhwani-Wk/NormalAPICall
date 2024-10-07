//
//  ViewController.swift
//  xibProject
//
//  Created by admin on 06/09/24.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var TableView: UITableView!
    var sectionTitleArr = ["Sujal's extension story", "Dhwani's dance story"]
    private var jokeArr: [JokeModel] = []
//    we add varable for getting differnt jokes in sectionTitle
    var jokesBySection: [String: [JokeModel]] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        getJokes() //Fetch jokes when view is loaded.
    }
    
    func reloadTable(){
            DispatchQueue.main.async {
                self.TableView.reloadData()

            }
        }
    
    func getJokes() {
            let urlStr = "https://official-joke-api.appspot.com/jokes/random/50"
            if let url = URL(string: urlStr) {
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    guard let receivedData = data else {
                        print("received Data successfully")
                        return
                    }
                    do {
                        let jokes = try JSONDecoder().decode([JokeModel].self, from: receivedData)
                        
                      // Divide jokes among sections
                        let midIndex = jokes.count/2
                        let section1Jokes = Array(jokes[0..<midIndex])
                        let section2Jokes = Array(jokes[midIndex..<jokes.count])
                        
                        self.jokesBySection[self.sectionTitleArr[0]] = section1Jokes
                        self.jokesBySection[self.sectionTitleArr[1]] = section2Jokes
                        
//                        self.jokeArr.append(contentsOf: jokes)
                        self.reloadTable()
                        print("Jokes are here:\(self.jokesBySection)") //printing jokebysection
//                        print("Jokes are here:\(self.jokeArr)")
                            
                    } catch {
                        debugPrint("something went wrong: \(error.localizedDescription)")
                    }
                }
                dataTask.resume()
            } else {
                print("Invalid URL, please check URL and try again")
            }
        }

    }

//MARK: - Tableview methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func setupTable() {
        TableView.dataSource = self
        TableView.delegate = self
        TableView.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "JokeCell")
    
    }
    
    func numberOfSection(in tableView: UITableView) -> Int {
        return sectionTitleArr.count // count is use for array
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sectionTitleArr[section]
        return jokesBySection[sectionTitle]?.count ?? 0
//        return jokeArr.count // count is use for array
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as! JokeCell
        let sectionTitle = sectionTitleArr[indexPath.section]
//        let joke = jokeArr[indexPath.row]
        if let joke = jokesBySection[sectionTitle]?[indexPath.row]{
            cell.idLabel.text = "\(indexPath.row + 1)" // index will start with 1 for that we have written +1
            cell.punchlineLabel.text = joke.punchline
            cell.setupLabel.text = joke.setup
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(section)
        return sectionTitleArr[section]
    }

}
