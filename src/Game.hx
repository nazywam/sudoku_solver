import flash.display.Sprite;
import flash.display.Stage;

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import flash.events.MouseEvent;
class Game extends Sprite{
	public function rowIsOk(row : Int, board : Array<Array<Field>>, checkTable : Array<Int>){
		for (x in 0...9) {
			checkTable[x] = 0;
		}
		for (x in 0...9) {
			checkTable[board[row][x].value-1]++;
		}
		for (x in 0...9) {
			if(checkTable[x] > 1){
				return false;
			}
		}
		return true;
	}
	public function columnIsOk(column : Int, board : Array<Array<Field>>, checkTable : Array<Int>){
		for (y in 0...9) {
			checkTable[y] = 0;
		}
		for (y in 0...9) {
			checkTable[board[y][column].value-1]++;
		}
		for (y in 0...9) {
			if(checkTable[y] > 1){
				return false;
			}
		}
		return true;
	}
	public function squareIsOk(row : Int, column : Int, board : Array<Array<Field>>, checkTable : Array<Int>){
		for (i in 0...9) {
			checkTable[i] = 0;
		}
		for (y in 0...3) {
			for (x in 0...3) {
				checkTable[board[row*3 + y][column*3 + x].value-1]++;
			}
		}
		for (i in 0...9) {
			if(checkTable[i] > 1){
				return false;
			}
		}
		return true;
	}
	public function boardIsOk(board : Array<Array<Field>>){
		var checkTable = new Array<Int>();
		for (i in 0...9) {
			checkTable.push(0);
		}
		for (x in 0...9) {
			if(!columnIsOk(x, board, checkTable)) return false;
		}
		for (y in 0...9) {
			if(!rowIsOk(y, board, checkTable)) return false;
		}
		for (y in 0...3) {
			for (x in 0...3) {
				if(!squareIsOk(y, x, board, checkTable)) return false;
			}		
		}
		return true;
	}
	public function solve(index : Int, board : Array<Array<Field>>){
		//trace(index);
		if(index == 81) return true;
		//if(boardIsOk(board)) return true;
		if(board[Std.int(index/9)][index%9].value == 0){
			for (i in 1...10) {
				board[Std.int(index/9)][index%9].value = i;
				if(boardIsOk(board)){
					if(solve(index+1, board)){
						return true;
					}
				}
			}
			board[Std.int(index/9)][index%9].value=0;
			
		} else {
			return solve(index+1, board);	
		}
		return false;
		
	}
	public function reset(e : MouseEvent){
		for (y in 0...9) {
			for (x in 0...9) {
				board[y][x].value = 0;
				board[y][x].update();
			}
		}
	}
	public function start(e : MouseEvent){
		var start = flash.Lib.getTimer();
		solve(0, board);
		for (y in 0...9) {
			for (x in 0...9) {
				board[y][x].update();
			}
		}
		trace(flash.Lib.getTimer() - start);
	}
	var board : Array<Array<Field>>;
	public function new():Void {
		super();
		var current : flash.display.MovieClip = flash.Lib.current;
		current.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		board = new Array<Array<Field>>();
		for (y in 0...9) {
			board[y] = new Array<Field>();
			for (x in 0...9) {
				board[y][x] = new Field(x*80, y*80, 80, 0);
				current.addChild(board[y][x]);
			}
		}
		current.addChild(new Grid());

		{ //Reset button
			var button = new Sprite();
			button.x = 0;
			button.y = 720;

			button.graphics.beginFill(0xFFFFFF);
			button.graphics.drawRect(0, 0, 360, 80);
			button.graphics.endFill();
			button.graphics.lineStyle(3, 0x000000);
			button.graphics.drawRect(0, 0, 360, 80);

			var text = new TextField();
			text.width = 360;
			text.selectable = false;
			var format = new TextFormat(50, TextFormatAlign.CENTER);		
			text.defaultTextFormat = format;
			text.text = "Reset";
			button.addEventListener(MouseEvent.CLICK, reset);
			button.addChild(text);
			current.addChild(button);
		}
		{ //Solve button
			var button = new Sprite();
			button.x = 360;
			button.y = 720;

			button.graphics.beginFill(0xFFFFFF);
			button.graphics.drawRect(0, 0, 360, 80);
			button.graphics.endFill();
			button.graphics.lineStyle(3, 0x000000);
			button.graphics.drawRect(0, 0, 360, 80);

			var text = new TextField();
			text.width = 360;
			text.selectable = false;
			var format = new TextFormat(50, TextFormatAlign.CENTER);		
			text.defaultTextFormat = format;
			text.text = "Solve";
			button.addEventListener(MouseEvent.CLICK, start);
			button.addChild(text);
			current.addChild(button);
		}
	} 
	public function mouseDown(e : MouseEvent){
		if(e.stageX <= 720 && e.stageY <= 720){
			board[Std.int(e.stageY/80)][Std.int(e.stageX/80)].value++;
			board[Std.int(e.stageY/80)][Std.int(e.stageX/80)].update();	
		}	
	}
}