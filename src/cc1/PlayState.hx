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

	static var tileIDs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650, 630, 124, 860, 539, 662, 0, 184, 185, 105, 601, 537, 536, 538, 480, 43, 0, 0, 0, 1108, 1109, 1110, 0, 34, 96, 629, 0, 0, 689, 0, 50, 0, 882, 6, 0, 953, 680, 470, 298, 590, 233, 453, 1050, 1051, 300, 0, 0, 0, 0, 600, 154, 0, 0, 594, 150, 562, 250, 0, 0, 0, 299, 201, 950, 0, 201, 602, 603, 954, 0, 1104, 1105, 1106, 674, 605, 1052, 1053, 0, 0, 100, 604, 201, 1100, 559, 1101, 0, 580, 559, 12, 1102, 0, 0, 184, 0, 212, 0, 0, 0, 560, 0, 559, 0, 0, 0, 0, 558, 554, 3, 587, 0, 0, 0, 386, 499, 476, 477, 378, 379, 0, 0, 953, 954, 955, 0, 0, 0, 0, 0, 416, 420, 418, 424, 426, 425, 414, 649, 643, 646, 648, 644, 645, 0, 0, 0, 2, 598, 586, 856, 0, 0, 0, 0, 0, 0, 583, 588, 589, 579, 578, 540, 544, 546, 547, 1057, 1061, 0, 442, 443, 0, 0, 584, 582, 0, 590, 1056, 543, 557, 542, 0, 0, 0, 639, 594, 594, 581, 545, 541, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 548, 394, 395, 396, 397, 398, 399, 0, 0, 852, 0, 0, 1044, 8, 10, 182, 183, 0, 553, 561, 585, 498, 499, 476, 0];
	
	var player:Player;
	var tiles:FlxGroup;

	override public function create():Void
	{
		super.create();

		tiles = new FlxGroup();
		add(tiles);

		var width = 40;
		var height = 25;
		
		FlxG.worldBounds.set(0, 0, 16 * width, 16 * height);
		FlxG.camera.setBounds(0, 0, 16 * width, 16 * height);

		var bytes = Assets.getBytes("assets/maps.bin");
		
		bytes.position = 41*10;
		
		for(y in 0...height){
			trace(bytes.readByte());
			for (x in 0...width) {
				var id = (0xff & bytes.readByte()) % 0xff;
				if (id == 0x59) {
					player = new Player();
					player.setPosition(x * 16, y * 16);
					FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
					add(player);
				} else {
					var tileID = tileIDs[id];
					if(tileID != 0) {
						var block = new FlxTileblock(x*16, y*16, 16, 16);
						block.loadGraphic("assets/gfx.png", false, false, 16, 16);
						block.animation.frameIndex = tileID;
						tiles.add(block);
					}
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