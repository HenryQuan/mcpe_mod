//####################################################
//#   MCPE Mod 0.10.0 (For Minecraft PE 0.10.0 IOS)  #
//#													       #
//#					  Created by HenryQuan			 #
//#					      11/11/2014				     #
//####################################################




// Somthing happens >_<
//   #	 #    #     #	 ######   #	   #	   #	    #		     ###
//    #  #   #	    #	 #    #   #	   #	   #	    #		 ######
//    #  #  #	    #	 ###### ###########  #####	 ########   #  #
//     # # #	 ####### #	  #   #    #	  ## #	#   #	   #   #
//	###	       ##    ###### ###########  # #  #     #	  #	   # 
//##############  # # #  #  #	  #	   #	 # #  ########## ##########
//     #   #	 #  #  # #  # #   #	   # #	 # #	   # #		   #
//    #    #	    #	 #  #  #  #	   ###	   #	   #  #        #
//   #	   #	    #	 #######  #		       #	  #	   #	#  #  
//  #	   #	    #	 #  #	  #		       #	 #	    #	 # #	    
// #	   ####     #	 ## ###   #		       #    #	     #	  ##

#define PLIST_PATH @"/var/mobile/Library/Preferences/HenryQuan.MCPEMod.plist"
#import <substrate.h>
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

// To prevent spelling errors and the code looks clean.
#define KEEP_ALL_STAFFS "__ZN6Player3dieEP6Entity"

#define SNEAKING "__ZN11LocalPlayer10isSneakingEv"

#define NO_FALL_DAMAGE "__ZN11LocalPlayer15causeFallDamageEf"

#define CAN_HURT_PLAYER "__ZN6Player4hurtEP6Entityi"

#define PLAYER_WALKING_SPEED "__ZN6Player23getWalkingSpeedModifierEv"

#define IS_IN_WALL "__ZN6Player8isInWallEv"

#define ARMOR_VALUE "__ZN6Player13getArmorValueEv"

#define INSTANT_DESTROY_PICKAXE "__ZN11PickaxeItem15getDestroySpeedEP12ItemInstanceP4Tile"
#define INSTANT_DESTROY_ITEM "__ZN4Item15getDestroySpeedEP12ItemInstanceP4Tile"
#define INSTANT_DESTROY_AXE "__ZN11HatchetItem15getDestroySpeedEP12ItemInstanceP4Tile"
#define INSTANT_DESTROY_DIGGER "__ZN10DiggerItem15getDestroySpeedEP12ItemInstanceP4Tile"

#define INSTANT_KILL "__ZN3Mob25getDamageAfterArmorAbsorbEi"

#define INFINITY_OXYGEN "__ZNK6Entity13isUnderLiquidEPK8Material"

#define IS_IN_WATER "__ZNK6Entity9isInWaterEv"
#define IS_IN_LAVA "__ZN6Entity8isInLavaEv"

#define STUCK_IN_WEB "__ZN6Entity14makeStuckInWebEv"

#define BIGGER_INVENTORY "__ZNK9Inventory16getContainerSizeEv"

/*
#define MAX_STACK_SIZE "__ZN4Item15setMaxStackSizeEi"
Crushes when launching the app (version 0.10.0)
*/

#define MOB_GET_TARGET "__ZN3Mob9getTargetEv"
#define MOB_FIND_TARGET "__ZN7Monster16findAttackTargetEv"

#define NO_EXPLOSION "__ZN5Level7explodeEP6Entityffffb"

#define DIRT_TO_STH "__ZN4Tile11getResourceEiP6Random"

#define GET_DROP_COUNT "__ZN9Inventory3addEP12ItemInstance"

// Prevent repetitive code
inline bool GetBool(NSString *key) 
{
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

// Prevent repetitive code (same as above)
inline int GetInt(NSString *key) 
{
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

void keepAllStaffs()
{
// Should not remove all the items
}

float noFallDamage()
{
return 0.f;
}

BOOL isSneaking()
{
return true;
}

BOOL isNotSneaking()
{
return false;
}

float sneakingSpeed()
{
return 0.55f;
}

float normalSpeed()
{
return 1.f;
}

float sprintSpeed()
{
return 2.5f;
}

void canNotHurtPlayer()
{
}

BOOL isNotInWall()
{
return false;
}

int GetArmorValue()
{
int result;
int armor = GetInt(@"customArmor");
if (armor == 1)
{
result = 0;
}
if (armor == 2)
{
result = 7;
}
if (armor == 3)
{
result = 12;
}
if (armor == 4)
{
result = 15;
}
if (armor == 5)
{
result = 11;
}
if (armor == 6)
{
result = 20;
}
if (armor == 7)
{
result = 999;
}
return result;
}

float instantDestroy()
{
// only use once so ...
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"customDigSpeed"] floatValue];
}

int instantKill()
{
// 50 is a big enough value to kill most of the mobs (enderman's HP is about 45 but below 50)
return 50;
}

BOOL isNotUnderWater()
{
return false;
}

BOOL isNotInWaterAndLava()
{
return false;
}

BOOL isInWater()
{
return true;
}

BOOL dontStuckInWeb()
{
return false;
}

int biggerInventory()
{
return 88;
}

/*
We don't need to use it now
int MaxStack()
{
return 999;
}
*/

int mobNoTarget()
{
return 0;
}

int mobCanNotFindTarget()
{
return 0;
}

BOOL noExplosion()
{
return false;
}

int customDrop()
{
return GetInt(@"customDrop");
}

int customCount()
{
return GetInt(@"customDropNum");
}

typedef struct {
	void vtable();
	int itemId; 
} Item;

typedef struct 
{
	int count; 
	int damage;
	Item item;
}*ItemInstance;

int (*old__ZN9Inventory3addEP12ItemInstance)(void self(), ItemInstance itemi);
int $__ZN9Inventory3addEP12ItemInstance(void self(), ItemInstance itemi)
{
itemi->count = GetInt(@"customDropNum");
return old__ZN9Inventory3addEP12ItemInstance(self, itemi);
}

UIButton *Sneaking;

%ctor
{
// The main control of the MOD
if (GetBool(@"main"))
{
// All the sub-switches
if (GetBool(@"keep"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, KEEP_ALL_STAFFS)),(void*)keepAllStaffs,NULL);
}
if (GetBool(@"noFallDamage"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, NO_FALL_DAMAGE)),(void*)noFallDamage,NULL);
}
if (GetBool(@"inWall"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, IS_IN_WALL)),(void*)isNotInWall,NULL);
}
if (GetBool(@"armor"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, ARMOR_VALUE)),(void*)GetArmorValue,NULL);
}
if (GetBool(@"instantBreak"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, INSTANT_DESTROY_PICKAXE)),(void*)instantDestroy,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, INSTANT_DESTROY_AXE)),(void*)instantDestroy,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, INSTANT_DESTROY_DIGGER)),(void*)instantDestroy,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, INSTANT_DESTROY_ITEM)),(void*)instantDestroy,NULL);
}
if (GetBool(@"instantKill"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, INSTANT_KILL)),(void*)instantKill,NULL);
}
if (GetBool(@"infinityOxygen"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, INFINITY_OXYGEN)),(void*)isNotUnderWater,NULL);
}
if (GetBool(@"walkingInWaterAndLava"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, IS_IN_WATER)),(void*)isNotInWaterAndLava,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, IS_IN_LAVA)),(void*)isNotInWaterAndLava,NULL);
}
if (GetBool(@"noGravity"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, IS_IN_WATER)),(void*)isInWater,NULL);
}
if (GetBool(@"stuckInWeb"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, STUCK_IN_WEB)),(void*)dontStuckInWeb,NULL);
}
/*
Crushes >_<
if (GetBool(@"maxStack"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, MAX_STACK_SIZE)),(void*)MaxStack,NULL);
}
*/
if (GetBool(@"biggerInventory"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, BIGGER_INVENTORY)),(void*)biggerInventory,NULL);
}
if (GetBool(@"mobsDontAttack"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, MOB_GET_TARGET)),(void*)mobNoTarget,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, MOB_FIND_TARGET)),(void*)mobCanNotFindTarget,NULL);
}
if (GetBool(@"noExplosion"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, NO_EXPLOSION)),(void*)noExplosion,NULL);
}
if (GetBool(@"dirtToAnything"))
{
MSHookFunction(((void*)MSFindSymbol(NULL, DIRT_TO_STH)),(void*)customDrop,NULL);
}
if (GetBool(@"getDropNumber"))
{
MSHookFunction(((int*)MSFindSymbol(NULL, GET_DROP_COUNT)),(int*)$__ZN9Inventory3addEP12ItemInstance,(int**)&old__ZN9Inventory3addEP12ItemInstance);
}
// The end of all the sub-switches
}

// Do nothing when the main switch id closed
else

{
// NOTHING¡¡HERE
}

// The end of the functions that loads when the game opens/runs.
}

%hook minecraftpeViewController
- (void)viewDidLoad
{
// The main control of the MOD
if (GetBool(@"main"))
{

if (GetBool(@"sneaking"))
{
%orig();

Sneaking = [UIButton buttonWithType:UIButtonTypeRoundedRect];
Sneaking.frame = CGRectMake(0, 90, 40, 25);
[Sneaking setTitle:@"N" forState:UIControlStateNormal]; 
[Sneaking setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
Sneaking.backgroundColor = [UIColor blackColor];
[Sneaking addTarget:self action:@selector(switchMode) forControlEvents:UIControlEventTouchUpInside];
[[self view] addSubview:Sneaking];

// is better to put a label above the button, it looks nice.
UILabel *walking = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 55, 25)];
walking.text = @"walk";
[[self view] addSubview:walking];
}
}

else
{
%orig();
}

}

%new -(void)switchMode
{
if ([Sneaking.currentTitle isEqualToString:@"N"])
{
[Sneaking setTitle:@"S" forState:UIControlStateNormal];
MSHookFunction(((void*)MSFindSymbol(NULL, SNEAKING)),(void*)isSneaking,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, CAN_HURT_PLAYER)),(void*)canNotHurtPlayer,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, NO_FALL_DAMAGE)),(void*)noFallDamage,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, PLAYER_WALKING_SPEED)),(void*)sneakingSpeed,NULL);
}
else if ([Sneaking.currentTitle isEqualToString:@"S"])
{
[Sneaking setTitle:@"V" forState:UIControlStateNormal];
MSHookFunction(((void*)MSFindSymbol(NULL, SNEAKING)),(void*)isNotSneaking,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, CAN_HURT_PLAYER)),(void*)canNotHurtPlayer,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, NO_FALL_DAMAGE)),(void*)noFallDamage,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, PLAYER_WALKING_SPEED)),(void*)sprintSpeed,NULL);
}
else if ([Sneaking.currentTitle isEqualToString:@"V"])
{
[Sneaking setTitle:@"N" forState:UIControlStateNormal];
MSHookFunction(((void*)MSFindSymbol(NULL, SNEAKING)),(void*)isNotSneaking,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, CAN_HURT_PLAYER)),(void*)canNotHurtPlayer,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, NO_FALL_DAMAGE)),(void*)noFallDamage,NULL);
MSHookFunction(((void*)MSFindSymbol(NULL, PLAYER_WALKING_SPEED)),(void*)normalSpeed,NULL);
}
else
{
}

}

%end

// 12/11/2014 9:50pm ^_^
// 19/11/2014 16:16pm >_<
