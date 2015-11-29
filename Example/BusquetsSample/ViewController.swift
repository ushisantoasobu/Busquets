//
//  ViewController.swift
//  BusquetsSample
//
//  Created by SatoShunsuke on 2015/11/29.
//  Copyright © 2015年 moguraproject. All rights reserved.
//

import UIKit
import Busquets

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    private let list = [
        "http://soccerking.s3.amazonaws.com/wp-content/uploads/2014/08/get20140809_00010-500x333.jpg",
        "http://images.performgroup.com/di/library/Goal_Thailand/67/a/sergio-busquets_1tswa70lsd9jc1lepz0ewn6ilv.jpg?t=2012143044&w=620&h=430",
        "http://www.footballchannel.jp/wordpress/assets/2014/12/20141209_sergi_getty-560x373.jpg",
        "http://www.footballista.jp/wp-content/uploads/2015/02/460714026_news_Busquets.jpg",
        "http://www.soccerdigestweb.com/files/topics/12274_ext_04_0.jpg",
        "http://soccerking.s3.amazonaws.com/wp-content/uploads/2013/01/0067.jpg",
        "http://media2.fcbarcelona.com/media/asset_publics/resources/000/186/697/size_640x360/2015-09-26_BARCELONA-LAS_PALMAS_09-Optimized.v1443287579.JPG",
        "http://media3.fcbarcelona.com/media/asset_publics/resources/000/066/616/size_640x360/2013-09-14_BARCELONA-SEVILLA_02.v1379235220.JPG",
        "http://afpbb.ismcdn.jp/mwimgs/f/f/500x400/img_ffb636531d12bd42cdc24b8dd7ace131111641.jpg",
        "http://4.bp.blogspot.com/-N9HrKmHQgsk/UZjdHCcQJEI/AAAAAAAACUE/xUwLAQFJgWM/s1600/Sergio-Busquets-Barcelona-v.-Club-America-8-6-11-7.jpg",
        "http://static.goal.com/219900/219952.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - private

    func getView(nibName :String) -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        var views = nib.instantiateWithOwner(self, options: nil)
        return views[0] as! UIView
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.getView("ImageTableViewCell") as! ImageTableViewCell
        cell.setCustomImageUrlString(list[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    {
        return 240
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }

}

