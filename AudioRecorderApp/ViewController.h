//
//  ViewController.h
//  AudioRecorderApp
//
//  Created by Simplice Tchoupkoua on 08.12.12.
//  Copyright (c) 2012 Simplice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property(nonatomic, strong) AVAudioRecorder *audioRecorder;
@property(nonatomic, strong) AVAudioPlayer *audioPlayer;

- (IBAction)startRecorder:(id)sender;
- (IBAction)stopRecorder:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)volume:(id)sender;

@end
