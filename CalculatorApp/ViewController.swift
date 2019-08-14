//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 田内　翔太郎 on 2019/08/12.
//  Copyright © 2019 田内　翔太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 計算結果を表示するラベル
    @IBOutlet weak var resultCalculate: UILabel!
    
    // 画面上の数字
    var numberOnScreen: Double = 0
    // 前回表示されていた数字
    var previousNumber: Double = 0
    // 数値が入力されたかどうかの判断
    var inValue: Bool = false
    // 計算してもいいかどうかの判断
    var performingMath: Bool = false
    // ラベルを編集できるかどうか
    var editLabel: Bool = true
    // 四則演算の演算子
    var operation: Int = 0
    // 計算結果を入れる
    var result: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 0~9のボタン
    @IBAction func numbers(_ sender: UIButton) {
        if editLabel {
            if performingMath {
                resultCalculate.text = String(sender.tag)
                numberOnScreen = Double(resultCalculate.text!)!
                performingMath = false
            } else {
                resultCalculate.text = resultCalculate.text! + String(sender.tag)
                numberOnScreen = Double(resultCalculate.text!)!
            }
        }
        
        inValue = true
    }
    
    // +,-,÷,×のボタン
    @IBAction func actions(_ sender: UIButton) {
        editLabel = true
        if inValue && sender.tag != 10 && sender.tag != 15 {
            // 画面に表示されている数字を変数に代入
            previousNumber = Double(resultCalculate.text!)!
            switch sender.tag {
            case 11:
                resultCalculate.text = "÷"
            case 12:
                resultCalculate.text = "×"
            case 13:
                resultCalculate.text = "+"
            case 14:
                resultCalculate.text = "-"
            default:
                break
            }
            // 演算子を記憶
            operation = sender.tag
            // 計算していい
            performingMath = true
        } else if sender.tag == 15  {// = が押された時
            switch operation {
            case 11:
                result = previousNumber / numberOnScreen
            case 12:
                result = previousNumber * numberOnScreen
            case 13:
                result = previousNumber + numberOnScreen
            case 14:
                result = previousNumber - numberOnScreen
            default:
                resultCalculate.text = ""
            }
            
            // 小数点で値を分離
            let shosu: [String] = String(result).components(separatedBy: ".")
            // 小数点以下が0であるなら
            if shosu[1] == "0" {
                resultCalculate.text = String(Int(result))
                
            } else {
                resultCalculate.text = String(result)
            }
            editLabel = false
        } else if sender.tag == 10 { // C が押された時
            resultCalculate.text = ""
            result = 0
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            inValue = false
        }
     }
}

