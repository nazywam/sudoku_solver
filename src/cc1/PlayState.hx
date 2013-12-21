package cc1;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{

	var player:Player;
	
	override public function create():Void
	{
		super.create();

		player = new Player();
		this.add(player);
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