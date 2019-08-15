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
    
    /// 画面上の数字
    var numberOnScreen: Double = 0
    /// 前回表示されていた数字
    var previousNumber: Double = 0
    /// 四則演算の演算子
    var operation: String = ""
    /// 計算結果を入れる
    var result: Double = 0
    /// 数値が入力されたかどうかの判断
    var inValue: Bool = false
    /// 計算してもいいかどうかの判断
    var performingMath: Bool = false
    /// ラベルを編集できるかどうか
    var editLabel: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// クリアする関数
    func allClear() {
        // クリアする
        resultCalculate.text = ""
        result = 0
        previousNumber = 0
        numberOnScreen = 0
        operation = ""
        inValue = false
        editLabel = true
        performingMath = false
    }
    
    // 0~9のボタン
    @IBAction func numbers(_ sender: UIButton) {
        // 演算結果の上書き防止
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
    
    // +,-,÷,×,=,Cのボタン
    @IBAction func actions(_ sender: UIButton) {
        // ラベルを書き換えOK
        editLabel = true
            if sender.currentTitle == "C" { // Cが押されたとき
                // クリアする
                allClear()
            } else if inValue && sender.currentTitle == "="  {// = が押された時
                // 演算子を判定して、演算を実行
                switch operation {
                case "÷":
                    result = previousNumber / numberOnScreen
                case "×":
                    result = previousNumber * numberOnScreen
                case "+":
                    result = previousNumber + numberOnScreen
                case "-":
                    result = previousNumber - numberOnScreen
                default:
                    break
                }
                // 小数点で値を分離
                let shosus: [String] = String(result).components(separatedBy: ".")

                // 計算結果が無限ではない、かつ整数である時の処理
                if !result.isInfinite && shosus.last == "0" {
                    // 小数点以下が0であるなら
                    resultCalculate.text = String(Int(result))
                }else { // 小数点以下が0でない = 少数で表示する
                    resultCalculate.text = String(result)
                }
                    
                // 数値が入っている
                inValue = true
                // 数値を足せないようにする
                editLabel = false
            } else { // +,-,×,÷のいずれかが押されたとき
                // 画面に表示されている数字を変数に代入
                if inValue {
                    previousNumber = Double(resultCalculate.text!)!
                }
                // 「 = 」以外の演算子を表示
                if sender.currentTitle != "=" {
                    resultCalculate.text = sender.currentTitle
                }
                // 数値は入っていない
                inValue = false
                // 演算子を記憶
                operation = sender.currentTitle!
                // 計算していい
                performingMath = true
        }
    }
}

