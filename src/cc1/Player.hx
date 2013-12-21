package cc1;

import flixel.animation.FlxAnimation;
import flixel.FlxSprite;

class Player extends FlxSprite
{

	private function range(a, b) {
		var array = new Array<UInt>();
		for ( i in a...b) {
			array[i - a] = i;
		}
		return array;
	}
	
	public function new() 
	{
		super();
		
		loadGraphic("img/gfx.png", true, false, 16, 16);
		
		animation.add("lookRight", [250], 0);
		animation.add("walkRight", range(250, 262), 15);
		animation.add("lookLeft", [262], 0);
		animation.add("walkLeft", range(262, 274), 15);
		animation.add("jumpRight", [274], 0);
		animation.add("jumpLeft", [275], 0);
		animation.add("fireRight", [276], 0);
		animation.add("fireLeft", [277], 0);

		animation.play("fireRight");
		
	}
	
	override public function update():Void 
	{
		super.update();

	}
}