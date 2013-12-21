package cc1;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;


class MenuState extends FlxState
{

	override public function create():Void
	{
		FlxG.cameras.bgColor = 0xff131c1b;
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	
}