//
//  OOIMAP.h
//
//  Created by ��X�q�j on Thu May 20 2004.
//  Copyright (c) 2004 ��X�q�j. All rights reserved.
//
//IMAP�A�N�Z�X�̂��߂̃N���X�@10.3�ȏオ�K�v
//

#import <Foundation/Foundation.h>


@interface OOIMAP : NSObject<NSStreamDelegate> {
	//IBOutlet id myOutlet;
	//NSSecureTextField * passwordField;
	NSString *userName;
	NSString *passWord;
	
    NSInputStream *inputStream;
	NSOutputStream *outputStream;
	NSOutputStream *oStream;
	NSOutputStream *oStream2;
    NSInputStream *iStream;
	NSMutableData *_data;
	
	int currentCommand;//���߂̃R�}���h

}
//- (IBAction)testMD5:(id)sender;
- (void)myAction;
//POP3�R�}���h���M
- (void)sendCapability;
- (void)sendUser:(NSString *)userName;
- (void)sendPassword:(NSString *)passwordString;
- (void)list;
- (void)quit;
- (void)stat;
- (void)letter:(int)messageNum;
- (void)sendDelete:(int)messageNum;
- (void)top:(int)start length:(int)length;
- (void)noop;
- (void)resetDelete;
- (void)uidl:(int)messageNum;

//��M
- (void)handlePop3Recieve:(NSNotification *)notification;

- (void)handleInputStreamEvent:(NSStreamEvent)eventCode  stream:(NSStream *)aStream ;
- (void)handleOutputStreamEvent:(NSStreamEvent)eventCode  stream:(NSStream *)aStream ;



//���M
-(void)outputCommand:(NSString *)command commandCode:(int)commandCode;

//�A�N�Z�b�T���\�b�h
-(void)setCurrentCommand:(int)command;
-(int)currentCommand;
-(void)setUserName:(NSString *)name;
-(NSString *)userName;
-(void)setPassWord:(NSString *)name;
-(NSString *)passWord;


@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;

@property (strong, nonatomic) NSMutableData *recieveData;

@end
