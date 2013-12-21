package cc1;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTileblock;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{

	var player:Player;
	var tiles:FlxGroup;
	
	override public function create():Void
	{
		super.create();

		tiles = new FlxGroup();
		add(tiles);

		player = new Player();
		player.acceleration.y = 50;
		add(player);
		
		var block = new FlxTileblock(0, 32, 16, 16);
		block.loadGraphic("img/gfx.png", false, false, 16, 16);
		block.animation.frameIndex = 3;

		tiles.add(block);
		
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		FlxG.collide(player,tiles);

		super.update();
	}	
}