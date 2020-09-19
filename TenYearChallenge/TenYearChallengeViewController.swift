//
//  TenYearChallengeViewController.swift
//  TenYearChallenge
//
//  Created by 李世文 on 2020/9/14.
//

import UIKit

class TenYearChallengeViewController: UIViewController {

    @IBOutlet var photoImageViews: [UIImageView]!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var yearForSliderLabel: UILabel!
    @IBOutlet weak var yearForImageLabel: UILabel!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    //Timer
    var timer = Timer()
    //所有照片
    var photoImages = [UIImage](repeating: UIImage(), count: 11)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiKey = "f6dfa17f590461156a410f03144878c2"
        //密鑰：abec9ee5c3f45443
        let photoInforUrlStrs = [//所有API網址2010-2020
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2010-09-01 23:59:59&min_upload_date=2010-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2011-09-01 23:59:59&min_upload_date=2011-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2012-12-31 23:59:59&min_upload_date=2012-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2013-12-31 23:59:59&min_upload_date=2013-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2014-12-31 23:59:59&min_upload_date=2014-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2015-12-31 23:59:59&min_upload_date=2015-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2016-12-31 23:59:59&min_upload_date=2016-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2017-12-31 23:59:59&min_upload_date=2017-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2018-12-31 23:59:59&min_upload_date=2018-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2019-12-31 23:59:59&min_upload_date=2019-01-01 00:00:00&format=json&nojsoncallback=1",
            "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=Chloe Grace Moretz&per_page=20&max_upload_date=2020-09-15 23:59:59&min_upload_date=2020-01-01 00:00:00&format=json&nojsoncallback=1",
        ]
        
        for (index, photoInforUrlStr) in photoInforUrlStrs.enumerated(){
            if let urlStr = photoInforUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),//網址有空白，這裡處理一下
               let url = URL(string: urlStr){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data{
                        let photoData = try? JSONDecoder().decode(FeedData.self, from: data)//JSON解碼
                        var imageUrl: URL?
                        switch index {//每年20張選出最好看的1張
                        case 0:
                            imageUrl = photoData?.photos.photo[3].imageUrl
                        case 1:
                            imageUrl = photoData?.photos.photo[2].imageUrl
                        case 2:
                            imageUrl = photoData?.photos.photo[15].imageUrl
                        case 3:
                            imageUrl = photoData?.photos.photo[11].imageUrl
                        case 4:
                            imageUrl = photoData?.photos.photo[9].imageUrl
                        case 5:
                            imageUrl = photoData?.photos.photo[10].imageUrl
                        case 6:
                            imageUrl = photoData?.photos.photo[11].imageUrl
                        case 7:
                            imageUrl = photoData?.photos.photo[5].imageUrl
                        case 8:
                            imageUrl = photoData?.photos.photo[0].imageUrl
                        case 9:
                            imageUrl = photoData?.photos.photo[10].imageUrl
                        case 10:
                            imageUrl = photoData?.photos.photo[15].imageUrl
                        default:
                            break
                        }
                        if let imageUrl = imageUrl {//如果有取得圖片網址
                            //網路抓圖
                            self.getImage(url: imageUrl) { (image) in
                                if let image = image{//如果有抓到
                                    self.photoImages[index] = image//放進array
                                    DispatchQueue.main.async {
                                        if index == 0{//2010的直接丟畫面
                                            self.photoImageViews[0].image = image
                                        }else if index == 10{//2020的直接丟畫面
                                            self.photoImageViews[1].image = image
                                        }
                                        self.activityIndicator.stopAnimating()//轉圈圈動畫結束
                                    }
                                }
                            }
                        }
                        
                    }
                }.resume()
            }
        }
        
    }
    
    //取得網路圖片
    //function當參數傳入，closure寫法
    func getImage(url:URL, completionHandler: @escaping (UIImage?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data){
                completionHandler(image)
            }else{
                completionHandler(nil)
            }
        }.resume()
    }
    
    //動態設定畫面照片
    func setImage(yearStr: String){
        let years = ["2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]
        if photoImages.isEmpty{
           print("photoImages is empty")
        }else{
            for (index, year) in years.enumerated(){
                if yearStr == year{
                    photoImageViews[0].image = photoImages[index]
                }
            }
        }
    }
    
    //動態設定datePicker
    func setDatePicker(yearStr: String){
        var date = datePicker.date
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        let month = dateComponents.month
        let day = dateComponents.day
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let month = month,
           let day = day{
            date = dateFormatter.date(from: "\(yearStr)/\(month)/\(day)")!
            datePicker.date = date
        }
    }
    
    @IBAction func autoPlaySwitch(_ sender: UISwitch) {
        if sender.isOn == true{
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                var yearF = self.yearSlider.value
                if yearF == 2020{
                    yearF = 2010
                }else{
                    yearF += 1
                }
                let yearStr = String(format: "%.0f", yearF)
                self.yearForSliderLabel.text = yearStr
                self.yearForImageLabel.text = yearStr
                //設定slider
                self.yearSlider.setValue(yearF, animated: true)
                //設定datePicker
                self.setDatePicker(yearStr: yearStr)
                //設定照片
                self.setImage(yearStr: yearStr)
            }
        }else{
            timer.invalidate()
        }
    }
    
    @IBAction func calendarDatePicher(_ sender: UIDatePicker) {
        let date = sender.date
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        let yearStr = dateComponents.year?.description
        yearForSliderLabel.text = yearStr
        yearForImageLabel.text = yearStr
        if let yearStr = yearStr,
           let yearF = Float(yearStr){
            yearSlider.setValue(yearF, animated: true)//設定slider
            setImage(yearStr: yearStr)//設定照片
        }
        
    }
    
    @IBAction func yearChoice(_ sender: UISlider) {
        let year = roundf(sender.value)//四捨五入到整數
        let yearStr = String(format: "%.0f", year)
        yearForSliderLabel.text = yearStr
        yearForImageLabel.text = yearStr
        sender.value = year
        //設定datePicker
        setDatePicker(yearStr: yearStr)
        //設定照片
        setImage(yearStr: yearStr)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


struct FeedData: Decodable {
    let photos: Photos
}

struct Photos: Decodable {
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    
    var imageUrl: URL{
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_b.jpg")!
    }
}
