//
//  Slots Tryout
//
//  Created by Bob on 03/09/15.
//

import UIKit

class Slots: UIViewController {
    
    var names: [String] = ["Bell", "Lemon", "Orange", "Cherry"]
    var odds: [Int]   = [700, 300, 100, 1]
    var playOdds: [Int] = [0, 0, 0, 0]
    var payouts: [Int]  = [2, 10, 16, 100]
    var categoryWins: [Int] = [0, 0, 0, 0, 0]
    var gamesPlayed: Int = 0
    var totalStartMoney: Int = 0
    var totalPrizeMoney: Int = 0
    var totalMoney: Int = 0
    
    func run(numberOfGames: Int = 100) {
        var betAmount = 100
        totalStartMoney = betAmount * numberOfGames
        totalMoney = totalStartMoney
        gamesPlayed = 0
        resetOdds()
        
        for var i = 0 ; i < numberOfGames ; i++ {
            play(betAmount)
            gamesPlayed++
        }
        println("After \(gamesPlayed) games:")
        println("Gambled: \(totalStartMoney)")
        println("Total: \(totalMoney)")
        println("Won: \(totalPrizeMoney)")
        
        for var n = 0 ; n < names.count ; n++ {
            println("\(names[n]): \(categoryWins[n]) / \(gamesPlayed) won")
        }
    
    }
    
    func resetOdds(start: Int = 0) {
        for var i : Int = start ; i < odds.count ; i++ {
            playOdds[i] = odds[i]
        }
    }
    
    func play(betAmount: Int) {
        var winner = Int.random(lower: 0, upper: 10000)
        var oddsSum : Int = 0
        for var i: Int = playOdds.count-1 ; i > 0 ; i-- {
            if winner + oddsSum  <= playOdds[i] {
                println("Win: \(winner + oddsSum) < \(playOdds[i])")
                win(betAmount, oddIndex: i)
                return
            } else {
                oddsSum += playOdds[i]
            }
        }
        lose(betAmount)
    }
    
    func lose(betAmount: Int) {
        totalMoney -= betAmount
        println("Game \(gamesPlayed) - Lost \(betAmount)")
        
        for var i : Int = 0 ; i < odds.count ; i++ {
            playOdds[i] += odds[i]
        }
    }
    
    func win(betAmount:Int, oddIndex: Int) {
        resetOdds(start: oddIndex)
        categoryWins[oddIndex]++
        let prize = betAmount * payouts[oddIndex]
        totalPrizeMoney += prize - betAmount
        totalMoney += prize - betAmount
        println("Game \(gamesPlayed) - Won \(prize)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        run()
    }
}

