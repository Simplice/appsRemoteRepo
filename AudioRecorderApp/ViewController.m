//
//  ViewController.m
//  AudioRecorderApp
//
//  Created by Simplice Tchoupkoua on 08.12.12.
//  Copyright (c) 2012 Simplice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize audioPlayer, audioRecorder;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 1. recuperer le path qui mene au dossier /Documents/ de chaque IOS
    NSArray *chemins = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cheminDoc = [chemins objectAtIndex:0];
    // 2. metre notre fichier dans ce directoire /Documents/ en lui donant le nom "monSon.mp3" (path devient .../Documents/monSon.mp3
    NSString *soundFilePath = [cheminDoc stringByAppendingPathComponent:@"monSon.caf"];
    
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:24], AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                    nil];
    // 4. recuperer le URL du path menant au song
    NSURL *URLson = [NSURL fileURLWithPath:soundFilePath];
    NSError *error = nil;
    // 5. instancier et initialiser le variable audioRecoder
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:URLson settings:recordSettings error:&error];
    
    if (error) {
        NSLog(@"Erreur à l'initialisation de l'objet audioRecorder : %@", [error description]);
    }
    else {
        [audioRecorder prepareToRecord];
    }
    
    // ajouter une image gif dans le view
    NSData *gif = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dj" ofType:@"gif"]];
    UIWebView *view = [[UIWebView alloc] initWithFrame:self.view.frame];
    [view loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view insertSubview:view atIndex:0];
    // ajouter une image au backgroungColor
    //self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"dj.gif"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startRecorder:(id)sender {
    [self.audioRecorder record];
}

- (IBAction)stopRecorder:(id)sender {
    [self.audioRecorder stop];
}

- (IBAction)play:(id)sender {
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioRecorder.url error:&error];
    if (error)
        NSLog(@"Error: %@", [error description]);
    else
        [self.audioPlayer play];
}

- (IBAction)volume:(id)sender {
    UISlider *slider = sender;
    [self.audioPlayer setVolume:slider.value];
}
@end
