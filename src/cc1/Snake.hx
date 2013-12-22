package cc1;

import flixel.animation.FlxAnimation;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;

class Snake extends FlxSprite {
	var facingRight:Bool = true;
	var walking:Bool = false;

	private function range(a, b) {
		var array = new Array<Int>();
		for ( i in a...b) {
			array[i - a] = i;
		}
		return array;
	}

	public function new(X : Float, Y : Float)
	{
		super(X, Y);
		
		loadGraphic("assets/gfx.png", true, false, 16, 16);

		animation.add("walkLeft", range(154, 162), 15);
		animation.add("hiss", range(163, 169), 15, false);
		animation.add("walkRight", range(170, 178), 15);
		walking = true;

	}
	override public function update():Void 
	{
/*
		if(Std.random(150)==1)
		{
			animation.play("hiss");
			walking = false;
		}
		if(animation.finished){
			walking = true;
		}

*/
		velocity.y=100;
		if(isTouching(FlxObject.LEFT) || isTouching(FlxObject.RIGHT) || !isTouching(FlxObject.DOWN)){
			facingRight = !facingRight;
		}

		super.update();

		velocity.x = walking?facingRight?48: -48:0;
		var direction = facingRight?"Right":"Left";
		if(walking)
		{
			animation.play("walk" + direction);
		} else
		{
			animation.play("hiss");
		}
		
	}
}