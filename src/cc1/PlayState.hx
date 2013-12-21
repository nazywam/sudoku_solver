package cc1;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTileblock;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import haxe.io.Bytes;
import haxe.io.BytesData;
import haxe.Resource;
import openfl.Assets;

class PlayState extends FlxState
{

	var player:Player;
	var tiles:FlxGroup;
	
	override public function create():Void
	{
		super.create();

		tiles = new FlxGroup();
		add(tiles);

		var width = 40;
		var height = 20;
		
		player = new Player();
		FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
		FlxG.camera.setBounds(0, 0, 16 * width, 16 * height);
		add(player);
		
		var bytes = Assets.getBytes("assets/maps.bin");
		
		for(y in 0...height){
			trace(bytes.readByte());
			for (x in 0...width) {
				var tileID = bytes.readByte();
				if(tileID != 0x20) {
					var block = new FlxTileblock(x*16, y*16, 16, 16);
					block.loadGraphic("assets/gfx.png", false, false, 16, 16);
					block.animation.frameIndex = tileID;
					tiles.add(block);
				}
			}
		}
		
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