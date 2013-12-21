package cc1;

import flixel.animation.FlxAnimation;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Player extends FlxSprite
{

	var facingRight:Bool = true;
	var jumping:Bool = false;
	var walking:Bool = false;
	var shooting:Bool = false;

	private function range(a, b) {
		var array = new Array<Int>();
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
		
	}
	
	override public function update():Void 
	{
		super.update();

		if (FlxG.keyboard.pressed("LEFT", "A")) {
			facingRight = false;
			walking = true;
		} else if (FlxG.keyboard.pressed("RIGHT", "D")) {
			facingRight = true;
			walking = true;
		} else {
			walking = false;
		}
		
		shooting = FlxG.keyboard.pressed("ALT");
		
		if ( isTouching(FlxObject.FLOOR) ) {
			jumping = FlxG.keyboard.pressed("UP", "W");
		}
		
		var direction = facingRight?"Right":"Left";
		
		if ( jumping ) {
			animation.play("jump" + direction);
		} else if (shooting) {
			animation.play("fire" + direction);
		} else if (walking) {
			animation.play("walk" + direction);
		} else {
			animation.play("look" + direction);
		}
		
	}
}