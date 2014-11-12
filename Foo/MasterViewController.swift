//
//  MasterViewController.swift
//  Foo
//
//  Created by Brian on 11/11/14.
//  Copyright (c) 2014 Brian Morearty. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var managedObjectContext: NSManagedObjectContext? = nil
    var layoutCell: TableViewCell!

    let songs = [
        [ "Piano Man",
            "It's nine o'clock on a Saturday. The regular crowd shuffles in. There's an old man sitting next to me, making love to his tonic and gin. He says, Son can you play me a memory, I'm not really sure how it goes, But it's sad and it's sweet and I knew it complete when I wore a younger man's clothes." ],
        [ "Where, Oh Where Has My Little Dog Gone?",
            "Oh where, oh where has my little dog gone? Oh where, or where can he be?" ],
        [ "You Can't Always Get What You Want",
            "I saw her today at the reception, a glass of wine in her hand." ]
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let song = songs[indexPath.row]
                (segue.destinationViewController as DetailViewController).detailItem = song[1]
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let tableViewCell = cell as TableViewCell
        tableViewCell.topLabel.text = songs[indexPath.row % 3][0]
        tableViewCell.bottomLabel.text = songs[indexPath.row % 3][1]
        layoutCell.topLabel.preferredMaxLayoutWidth = self.tableView.bounds.size.width;
        layoutCell.bottomLabel.preferredMaxLayoutWidth = self.tableView.bounds.size.width;
    }
    
    // THIS IS THE FUNCTION WHERE I CALCULATE THE HEIGHT.
    //
    // It doesn't work consistently. If you run the app, you will see that some lyrics are fully shown
    // but others are too short vertically, and don't show the last line.  
    //
    // (The fact that the song TITLES have ellipses is not a problem. I did that on purpose. It's the 
    // second label, with word wrap, that is misbehaving.)
    //
    // I made sure to set up all the constraints in Main.storyboard, and there are no constraint-related
    // errors in the log when I run this.
    //
    // I based this on suggestions I found in these places:
    //   http://youtu.be/6KImie4ZMwk
    //   The comment from Avnish Gaur on the above video, about setting preferredMaxLayoutWidth.
    //   http://derpturkey.com/autosize-uitableviewcell-height-programmatically/
    //   http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
    // ... and lots more that I don't remember.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if layoutCell == nil {
            layoutCell = tableView.dequeueReusableCellWithIdentifier("Cell") as TableViewCell
        }
        
        // I also tried the following fixes, but none of them helped:
        //layoutCell.topLabel.sizeToFit()
        //layoutCell.bottomLabel.sizeToFit()
        //layoutCell.sizeToFit()
        //layoutCell.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(layoutCell.bounds))

        configureCell(layoutCell, atIndexPath: indexPath)
        layoutCell.layoutIfNeeded()
        
        // Get the height for the cell. Add padding of 1 point for cell separator.
        let height = layoutCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        return height + 1
    }

}

