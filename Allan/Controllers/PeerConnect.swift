//
//  PeerConnect.swift
//  Allan
//
//  Created by Tobias Sundstrand on 2015-03-01.
//  Copyright (c) 2015 Threadsafe Studio. All rights reserved.
//

import MultipeerConnectivity

typealias Acceptance = () -> Bool
typealias Found = (NSData) -> Void

class PeerConnect : NSObject, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate {
    
    let advertizer:MCNearbyServiceAdvertiser
    let browser:MCNearbyServiceBrowser
    let accept:Acceptance
    let found:Found
    let credentials:NSData?
    let serviceType = "allan-sync"
    let session:MCSession
    
    init(credentials:NSData?, accept:Acceptance, found:Found) {
        self.accept = accept
        self.found = found
        self.credentials = credentials
        let peerId = MCPeerID(displayName: NSUUID().UUIDString)
        self.browser = MCNearbyServiceBrowser(peer: peerId, serviceType: self.serviceType)
        self.advertizer = MCNearbyServiceAdvertiser(peer: peerId, discoveryInfo: nil, serviceType: self.serviceType)
        self.session = MCSession(peer: peerId)
        
        super.init()
        self.session.delegate = self
        self.advertizer.delegate = self
        self.browser.delegate = self
    }
    
    func broadcastSync() {
        self.advertizer.startAdvertisingPeer()
    }
    
    func findSync() {
        self.browser.startBrowsingForPeers()
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        let accept = self.accept()
        invitationHandler(accept, accept ? self.session : nil)
    }
    
    func browser(browser: MCNearbyServiceBrowser!, foundPeer pID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        browser.invitePeer(pID, toSession: self.session, withContext: nil, timeout: 0)
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        self.found(data)
        self.browser.stopBrowsingForPeers()
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        if state == .Connected && self.credentials != nil{
            var error: NSError?
            session.sendData(self.credentials, toPeers: [peerID], withMode: .Reliable, error: &error)
            if let error = error {
                println("\(error.localizedDescription)")
            }
        } else if state == .NotConnected {
            println("Not connected")
        }
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        stream.open()
    }
    
    func session(session: MCSession!, didReceiveCertificate certificate: [AnyObject]!, fromPeer peerID: MCPeerID!, certificateHandler: ((Bool) -> Void)!) {
        certificateHandler(true)
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
        println("\(error.localizedDescription)")
    }
    
    func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!) {
        println("\(error.localizedDescription)")
    }
    
}

