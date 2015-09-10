//
//  DupChatViewController.swift
//  PP
//
//  Created by SRIKARTHIK on 05/09/2015.
//  Copyright (c) 2015 PartyPal. All rights reserved.
//

import Foundation

class DupChatViewController: JSQMessagesViewController {
    
    var messages: [JSQMessage] = []
    
    var matchID: String?
    
    
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = PFUser.currentUser().username
        //self.senderDisplayName = PFUser.currentUser[PF_USER_FULLNAME] as! String
        
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
    
    }
    override var senderId: String! {
        get{
            
            return PFUser.currentUser().objectId
        }
        set{
            
            super.senderId = newValue
        }
    }
    
    override var senderDisplayName: String! {
        get{
            
            return PFUser.currentUser().username
        }
        set{
            
            super.senderId = newValue
        }
        
    }
//     func senderDisplayName() -> String! {
//        return PFUser.currentUser()!.objectId
//        
//    }
//    
//    
//    func senderId() -> String {
//        
//        return PFUser.currentUser()!.objectId
//    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        var data = self.messages[indexPath.row]
        
        
        return data
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return messages.count
    }
    
    //Styling Chat Bubbles
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        var data = self.messages[indexPath.row]
        if data.senderId == PFUser.currentUser().objectId {
            
            return outgoingBubble
        } else {
            
            return incomingBubble
            
        }
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(m)
        if let id = matchID {
            
            saveMessage(id, Message(message: text, senderID: senderId, date: date))
        }
        finishSendingMessage()
        
    }
    
    
}
