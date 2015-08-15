//
//  TableViewController.swift
//  HitList
//
//  Created by noprom on 15/8/15.
//  Copyright (c) 2015年 noprom. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var names = [String]() // 姓名
    var people = [NSManagedObject]()
    
    /**
    新增姓名
    
    :param: sender <#sender description#>
    */
    @IBAction func addName(sender: AnyObject) {
        // 警告框
        var alert = UIAlertController(title: "添加姓名", message: "请输入一个名字", preferredStyle: UIAlertControllerStyle.Alert)
        // 保存按钮
        let saveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) -> Void in
            
            let textField = alert.textFields![0] as! UITextField
            self.names.append(textField.text)
            // 保存姓名到core data
            self.saveName(textField.text)
            
            let indexPath = NSIndexPath(forRow: (self.names.count-1), inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        // 取消按钮
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action:UIAlertAction!) -> Void in
        }
        // 添加按钮到alert
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in}
        // 显示警告框
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /**
    保存数据到core data
    
    :param: name 姓名
    */
    func saveName(name: String) {
        // 1 取得总代理和托管对象内容总管
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // 2 建立一个entity
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        // 3 保存文本框中的name
        person.setValue(name, forKey: "name")
        
        // 4 保存entity到托管对象的内容总管中
        var error:NSError?
        if !managedContext.save(&error) {
            println("无法保存\(error), \(error?.userInfo)")
        }
        
        // 5 保存到数组中
        people.append(person)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return names.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        let person = people[indexPath.row]
        cell.textLabel?.text = person.valueForKey("name") as! String?
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
