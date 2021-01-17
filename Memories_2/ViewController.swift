//
//  ViewController.swift
//  Memories_2
//
//  Created by Abnertw on 2021/1/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cutePetImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    // 先將以下眾多的照片以陣列的方式進行順序性的排列，並存於常數中，以備使用
    // 注意：傳入至Assets的照片檔名要小寫。例如:xxx.png
    let yearImages = ["20110407", "20120701","20130528","20140219","20151030", "20160101", "20170318","20180921","20191209","20201226"]
    

    
    // 若要將上述的照片陣列與datePicker一一對照的話，
    // 就要先讀取日期系統之一的DateFormatter()
    // 補充：Swift的Date因為無法獨自顯示於畫上，
    //      所以必須透過String來做轉換才能呈現
    // 所以我們可以先宣告一個空的日期字串，並存於變數中，以供使用
    // 並建立一個func及使用適用於多個如果的switch case來做對照
    // 對照完後，即可將我們自己所指定的日期與格式存入常數中
    // 再將常數存入datePicker的date中
    let dateFormatter = DateFormatter()
    var dateString:String = ""
    func contrast(number:Int) {
        switch number {
        case 0:
            dateString = "20110407"
        case 1:
            dateString = "20120701"
        case 2:
            dateString = "20130528"
        case 3:
            dateString = "20140219"
        case 4:
            dateString = "20151030"
        case 5:
            dateString = "20160101"
        case 6:
            dateString = "20170318"
        case 7:
            dateString = "20180921"
        case 8:
            dateString = "20191209"
        default:
            dateString = "20201226"
        }
        let date = dateFormatter.date(from: dateString)
        datePicker.date = date!
    }
    
    
    
    // 解釋：接下來要處理的是，比較陣列中的資料
    // 先宣告一個變數，以備使用
    // 再建立一個func及運用if else去做比較，
    // 比較的方式，可依個人需求做不同的條件設定
    // 條件設定與比較完成後，就將所宣告的變數轉為Float，並存入slider的值中
    // 與slider連動後，每次滑動即增加1次照片數量
    var imageNumber = 0
    func compare() {
        if imageNumber >= yearImages.count {
            imageNumber = 0
            contrast(number: imageNumber)
            cutePetImageView.image = UIImage(named: yearImages[imageNumber])
        } else {
            contrast(number: imageNumber)
            cutePetImageView.image = UIImage(named: yearImages[imageNumber])
        }
        yearSlider.value = Float(imageNumber)
        imageNumber += 1
    }
    
    
    
    // 解釋：在對照與比較完照片數量後，即可始開啟timer(計時器)
    // 開啟計時器後，先建立一個func
    // 並於大括號內，要求計時器所要做的功能，如:
    // withTimeInterval(計時器每幾秒更換一張照片)
    // repeat(是否重複播放)
    // block(計時器觸發時，所要做的事)
    var timer:Timer?
    func time() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in self.compare()
        })
    }
    
    
    
    // 先宣告一個常數，並將datePicker的date資料存入常數中，以備使用
    // 解釋：若要單獨取得單一項目，例如:我只想要取得年或分或時區的資料等等，
    //      則可使用Date另一個系統，即Calendar的components來將Date拆開使用
    //      由於我的照片是以一年一張為單位，所以我只要取得components年的資料即可
    //      不需要Date的月、日、時、分、時區等資料
    // 再宣告一個常數，去存入Calendar的components的相關資料
    // 宣告變數year，以取得components年的資料，再存入變數中
    // 由於照片陣列的index是從0開始，而取出的年份之起始值為1，故要-=1
    // 將components的年帶入陣列中，再帶入畫面中(imageView)呈現出來
    @IBAction func changeDP(_ sender: UIDatePicker) {
        let imageDate = datePicker.date
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: imageDate)
        var year = dateComponents.year!
        year -= 1
        cutePetImageView.image = UIImage(named: yearImages[year])
    }
    
    
    
    // 將sliderValue設為0，以備使用
    // 將slider的值以四捨五入的方式呈現
    // 而後再將slider的值轉成整數，並存入sliderValue的變數中
    // 最後再將sliderValue帶入陣列中，並再帶入畫面中(imageView)呈現出來
    var sliderValue = 0
    @IBAction func changeSL(_ sender: UISlider) {
        sender.value.round()
        sliderValue = Int(sender.value)
        cutePetImageView.image = UIImage(named: yearImages[sliderValue])
    }
    
    
    
    // switch，通常使用if else來做開關的判斷
    // 假如開關為開啟狀態
    // 就將time()給開啟
    // slider的值必需等同輸入到Assets中照片的數量，並將其轉成型別Float
    // 不然的話，就將計時器停掉(計時器失效)
    @IBAction func autoPlaySW(_ sender: UISwitch) {
        if sender.isOn {
            time()
            imageNumber = sliderValue
            yearSlider.value = Float(imageNumber)
        } else {
            timer?.invalidate()
        }
    }
    
    
    
    // viewDidLoad為最開始的啟動程式
    // 於viewDidLoad的大括號內寫入datePicker的當地時間與格式
    // 一開始進入模擬器時，即開啟時間time
    // zh為華語之意。將datePicker改為中文化格式
    // 將自定的yyyyMMdd格式帶入dateFormatter的dateFormat中
    override func viewDidLoad() {
        super.viewDidLoad()
        time()
        datePicker.locale = Locale(identifier: "zh-TW")
        dateFormatter.dateFormat = "yyyyMMdd"
    }
}

