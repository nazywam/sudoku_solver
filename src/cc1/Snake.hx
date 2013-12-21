package cc1;

import flixel.animation.FlxAnimation;
import flixel.FlxSprite;
import flixel.FlxG;

clas Snake extends FlxSprite {
	public function new(){
		super();
		
		loadGraphic("assets/gfx.png", true, false, 16, 16);

		animation.add("hiss", range(163, 169), 15);
	}
}