//
//  ViewController.swift
//  JSON
//
//  Created by Miguel Paolo Bravo on 7/27/17.
//  Copyright © 2017 Miguel Paolo Bravo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [[String: Any]]()
    let totalSearches = 50000
    let salLimitMax = 50000.0
    let salLimitMin = 48900.0
    let minSal = 4000.0
    
    // max sal
    // get median

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
          //let urlString = "http://api.football-data.org/v1/soccerseasons"
        // http://api.suredbits.com/sport/version/searchParameter/subParameters
        // \(searchWord)
        //
     // let urlString = "https://api.mysportsfeeds.com/v1.2/pull/nba/2017-2018-regular/daily_dfs.json?fordate=20171201"
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
      //  let urlString = "http://api.football-data.org/v1/competitions/?season=2015"
     //   let urlString = "http://api.football-data.org/v1/teams/66/fixtures/"
        
    
        let username = "luigi"
        let password = "41Rr3tina"
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        // create the request
        let url = URL(string: "https://api.mysportsfeeds.com/v1.2/pull/nba/2017-2018-regular/daily_dfs.json?fordate=20180119")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        //making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
           // print("\(JSON(data)) ")
            
            let json = JSON(data!)
           
         //   print("\(json["dailydfs"]["dfsEntries"][0]["dfsRows"])")
            

            
            guard let data = data, error == nil else {
            
               // print("\()")
                
//                    if json["teams"].count > 0 {
//
//                        print("OK to parse")
//
//                        DispatchQueue.main.async {
//                            // self.parse(json: json)
//                        }
//
//                    }
                    
                
                
                print("\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                // check status code returned by the http server
                print("status code = \(httpStatus.statusCode)")
                // process result
                
                if httpStatus.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.parse2(json: json)
                    }
                }
                
                
            }
        }
        task.resume()
 
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
      //  print("petition == \(petition)")
//        cell.textLabel?.text = petition["name"]
//        cell.detailTextLabel?.text = petition["shortName"]
        return cell
    }
    
    
    func parse(json: JSON) {
        
        // add salary to 60,000 fanduel and postion- less than 60,000
        // add all the points from
        
        for result in json["teams"].arrayValue {
//            let title = result["title"].stringValue
//            let body = result["body"].stringValue
//            let sigs = result["signatureCount"].stringValue
           // print("result \(result)")
            let name = result["name"].stringValue
            let code = result["code"].stringValue
            let shortName = result["shortName"].stringValue

            // links
            
            let obj = ["name": name, "code": code, "shortName": shortName]
            petitions.append(obj)
        }
        
        tableView.reloadData()
        
//        for result in json["fixtures"].arrayValue {
//            let title = result["homeTeamName"].stringValue
//            let body = result["date"].stringValue
//            let sigs = result["awayTeamName"].stringValue
//            let obj = ["homeTeamName": title, "date": body, "awayTeamName": sigs]
//            petitions.append(obj)
//        }
//        
        tableView.reloadData()
    }
    
    
    func parse2(json: JSON) {
    
        // json["dailydfs"]["dfsEntries"][0]["dfsRows"]
        // 0 draftK 1 fand
        // "team", "game", "player", "salary", "fantasyPoints"
        // "player" - "FirstName", "Position", "LastName"
        // save every player, salary, points to one object
        // then add to array
        //
        
     //   print("\(json["dailydfs"]["dfsEntries"][0]["dfsRows"])")
        
        for result in json["dailydfs"]["dfsEntries"][1]["dfsRows"].arrayValue {
     
           // print("\(result)")
            
            let name1 = result["player"]["FirstName"].stringValue
            let name2 = result["player"]["LastName"].stringValue
            let postion = result["player"]["Position"].stringValue
            
            let salary = result["salary"].doubleValue
            let fantasyPoints = result["fantasyPoints"].doubleValue
         
            let obj = ["playerName": name1 + " " + name2, "playerPosition": postion, "salary": salary, "fantasyPoints": fantasyPoints] as [String : Any]
            petitions.append(obj)
        }
       
       // print("\(petitions[Int(arc4random_uniform(UInt32(petitions.count)))])")
        
        // for every petition
        // add random element from array
        // check if name is in array if not add it
        
        
        // unique postions
     
        var array = [TestObj]()
        var array2 = [[TestObj]]()
       // var obj2 = TestObj
        var salary = [Double]() // under 50 000
        var salary2 = Double()
        var fPoints = Double()
       // var postion = [Int]() // 10 exactly
        var lineUpObjArr = [LineUpBaskObj]()
      //  var array = [TestObj]()
        
        
        var pg = ""
        var sg = ""
        
        var sf = ""
        var pf = ""
        
        var g = ""
        var f = ""
        
        var c = ""
        var u = ""
        
        var lineUpObj = LineUpBaskObj(pg: pg, sg: sg, g: g, sf: sf, pf: pf, f: f, c: c, u: u, salary: -1, fantasyPoints: -1)
        var counter = 0
        
        print("petitions.count = \(petitions.count)")
        
        for _ in 0..<totalSearches  {
            
            for _ in 0..<10  {
                
                let obj = petitions[Int(arc4random_uniform(UInt32(petitions.count)))]
               
               // salary2 += obj["salary"] as! Double
              
                let obj3 = TestObj(playerName: obj["playerName"] as! String, playerPosition: obj["playerPosition"] as! String, salary: obj["salary"] as! Double, fantasyPoints: obj["fantasyPoints"] as! Double)
          
                while (pg == "" || sg == "" || g == "" ||  sf == "" || pf == "" || f == "" || c == "" || u == "") {
                    counter += 1
                    // print("while loop \(counter)")
                    
                    let testObj = petitions[Int(arc4random_uniform(UInt32(petitions.count)))]
                    
                    let name = testObj["playerName"] as! String
                    var fPoints2 = String(testObj["fantasyPoints"] as! Double)
                    
                    if fPoints2 == "0.0"{
                        fPoints2 = " ZERO "
                      //  print("break")
                        break
                    }
                    
                    var sal2 = String(testObj["salary"] as! Double)
                    
                    if (testObj["salary"] as! Double) < minSal {
                        sal2 = sal2 + " null "
                        
                    }
                    
                    
                    
                    
                    
                    let playerP = testObj["playerPosition"] as! String!
                    
                    var prevP = ""
                    
                  // print("salary = \(testObj["salary"] as! Double) ")
                    
                    // name != prevP
                    if playerP == "PG" && pg == ""{
                        pg = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = pg
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    // name != prevP
                    if playerP == "SG" && sg == ""{
                        sg = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = sg
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    //  name.range(of:pg) == nil && name.range(of:sg) == nil)
                    if g == "" && (playerP == "PG" || playerP == "SG") && (pg != "" && sg != "" && !pg.contains(name) && !sg.contains(name)) {
                        g = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if playerP == "SF" && sf == ""{
                        sf = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if playerP == "PF" && pf == ""{
                        pf = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if f == "" && (playerP == "SF" || playerP == "PF") && (sf != "" && pf != "" && !sf.contains(name) && !pf.contains(name)){
                        f = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if playerP == "C" && c == "" {
                        c = playerP! + "  S: " + sal2 + " " + name + " " + fPoints2
                        prevP = name
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                    }
                    
                    if pg != "" && sg != "" && g != "" &&  sf != "" && pf != "" && f != "" && c != "" && !pg.contains(name) && !sg.contains(name) && !sf.contains(name) && !pf.contains(name) && !f.contains(name) && !g.contains(name) && !c.contains(name) {
                        u = playerP! + " S: " + sal2 + " " + name + " " + fPoints2
                        salary2 += testObj["salary"] as! Double
                        fPoints += testObj["fantasyPoints"] as! Double
                        
                      //  print("n = \(name) p = \(prevP)")
                        
                    }
                    
                    
                }
                
                
                
                array.append(obj3)
                
            }
           // print("salary2 \(salary2)")
            if salary2 < 50000 && salary2 > salLimitMin {
//                salary.append(salary2)
//                array2.append(array)
                
              //  print("salary2 < 50000 && salary2 > 45000")
                
                lineUpObj = LineUpBaskObj(pg: pg, sg: sg, g: g, sf: sf, pf: pf, f: f, c: c, u: u, salary: salary2, fantasyPoints: fPoints)
                
                lineUpObjArr.append(lineUpObj)
                
                
                
            }
            
            pg = ""
            sg = ""
            
            sf = ""
            pf = ""
            
            g = ""
            f = ""
            
            c = ""
            u = ""
            
            array.removeAll()
            salary2 = 0
            fPoints = 0
        }
        
     //    print("\(salary.sorted())")
     //   array2.sort { $0.salary < $1.salary}
      //  print("\(array2)")
        var sal = 0.0
        var name = ""
        var tempArr = [Double:String]()
        var index = 0
       // print("array2.count \(array2.count)")
        for i in array2{
           // tempArr = i
          //  tempArr.sorted { $0.salary < $1.salary}
            for j in i {
                sal += j.salary
                index += 1
                name += " \(index). " + j.playerName
            }
          //  print("\(sal)")
           // let obj = [sal : name]
            tempArr[sal] = name
            
            name = ""
            sal = 0
            index = 0
        }
        let sorted = Array(tempArr).sorted(by: { $0.0 > $1.0 })
     //   print("sorted = \(sorted)")
//        for i in sorted{
//
//            print("\(i)")
//
//        }
       // tableView.reloadData()
        
        print("lineUpObjArr.count \(lineUpObjArr.count) \n\n")
        
        
        
        let sorted3 = lineUpObjArr.sorted(by: { $0.fantasyPointsTotal > $1.fantasyPointsTotal })
        var rankCount = 0
        var rankCount1 = 0
        
        let size = Int(sorted3.count/3)
//        for i in 0..<size{
//            let j = sorted3[i]
//            rankCount1 += 1
//            print("Rank: \(rankCount1) / \(sorted3.count)")
//            print("Salary \(j.salaryTotal!) | Points \(j.fantasyPointsTotal!) \n")
//            print("1. \(j.PGposition!)")
//            print("2. \(j.SGposition!)")
//            print("3. \(j.SFposition!)")
//            print("4. \(j.PFposition!)")
//            print("5. \(j.Cposition!)")
//            print("6. \(j.Gposition!)")
//            print("7. \(j.Fposition!)")
//            print("8. \(j.Uposition!)")
//            print("-----------------\n")
//        }
        let sorted2 = lineUpObjArr.sorted(by: { $0.salaryTotal > $1.salaryTotal })
        
        
        var counter257 = 0
        var counter257Less = 0
        
        for i in sorted3 {
//            rankCount += 1
//            print("Rank2: \(rankCount) / \(sorted3.count)")
//            print("Salary2 \(i.salaryTotal!) | Points \(i.fantasyPointsTotal!) \n")
//            print("1. \(i.PGposition!)")
//            print("2. \(i.SGposition!)")
//            print("3. \(i.SFposition!)")
//            print("4. \(i.PFposition!)")
//            print("5. \(i.Cposition!)")
//            print("6. \(i.Gposition!)")
//            print("7. \(i.Fposition!)")
//            print("8. \(i.Uposition!)")
//            print("-----------------\n")
            
            
            // if salaryTotal > 49000 && salaryPer > 3500 (null)
            rankCount += 1
            if i.salaryTotal > 49000.0 &&
                !i.PGposition.contains("null") &&
                !i.SGposition.contains("null") &&
                !i.SFposition.contains("null") &&
                !i.PFposition.contains("null") &&
                !i.Cposition.contains("null") &&
                !i.Gposition.contains("null") &&
                !i.Fposition.contains("null") &&
                !i.Uposition.contains("null") &&
                
                !i.PGposition.contains("ZERO") &&
                !i.SGposition.contains("ZERO") &&
                !i.SFposition.contains("ZERO") &&
                !i.PFposition.contains("ZERO") &&
                !i.Cposition.contains("ZERO") &&
                !i.Gposition.contains("ZERO") &&
                !i.Fposition.contains("ZERO") &&
                !i.Uposition.contains("ZERO")
                
            {
                
                    print("Rank2: \(rankCount) / \(sorted3.count)")
                    print("Salary2 \(i.salaryTotal!) | Points \(i.fantasyPointsTotal!) \n")
                    print("1. \(i.PGposition!)")
                    print("2. \(i.SGposition!)")
                    print("3. \(i.SFposition!)")
                    print("4. \(i.PFposition!)")
                    print("5. \(i.Cposition!)")
                    print("6. \(i.Gposition!)")
                    print("7. \(i.Fposition!)")
                    print("8. \(i.Uposition!)")
                    print("-----------------\n")
                
                if i.fantasyPointsTotal > 256 {
                    counter257 += 1
                }else{
                    counter257Less += 1
                }
            }
            
           
        }
        
         print("counter257 = \(counter257)")
        print("counter257Less = \(counter257Less)")
    }

}

//extension String {
//    func contains(find: String) -> Bool{
//        return self.range(of: find) != nil
//    }
//    func containsIgnoringCase(find: String) -> Bool{
//        return self.range(of: find, options: .caseInsensitive) != nil
//    }
//}

