//
//  WeatherTableViewCell.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    @IBOutlet private var imageView_: UIImageView?
    @IBOutlet private var dateLbl: UILabel?
    @IBOutlet private var tempLbl: UILabel?

    var temp: ALWeatherModel? {
        didSet {
            guard let temp = temp else {
                return
            }
            dateLbl?.text = temp.weather.date
            tempLbl?.text = temp.weather.temp
            if let url = URL(string: temp.weather.icon) {
                downloadImage(from: url)
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async {
                self.imageView_?.image = UIImage(data: data)
            }
        }
    }
}
