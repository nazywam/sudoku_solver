import flash.display.Sprite;
import flash.display.Stage;

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import flash.events.MouseEvent;
class Game extends Sprite{ //główna klasa odpowiedzialna za nadzorowanie całego działania programu

	//funkcja sprawdzająca czy dany wiersz spełnia zasady sudoku, -czy wartości się nie powtarzają(za wyjątkiem 0, które oznacza puste pole)
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
	//funkcja sprawdzająca daną kolumnę
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
	//funkcja sprawdzająca mały kwadrat 3x3
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
	//funkcja sprawdzająca całą planszę za pomocą utworzonych wcześniej metod
	public function boardIsOk(board : Array<Array<Field>>){
		var checkTable = new Array<Int>(); //tablica służąca do zliczania występowania wartości
		for (i in 0...9) {
			checkTable.push(0);
		}
		for (x in 0...9) {
			if(!columnIsOk(x, board, checkTable)) return false; //sprawdzanie wszystkich kolumn
		}
		for (y in 0...9) {
			if(!rowIsOk(y, board, checkTable)) return false; //sprawdzanie wszystkich wierszy
		}
		for (y in 0...3) {
			for (x in 0...3) {
				if(!squareIsOk(y, x, board, checkTable)) return false; //sprawdzanie wszystkich kwadratów
			}		
		}
		return true;
	}
	//główna funkcja rekurencyjna która ma za zadanie wypełniać wszystkie wolne pola planszy wszystkimi możliwymi kombinacjami,
	//dopóki cała plansza nie zostanie zapełniona i nie będzie ona poprawna
	public function solve(index : Int, board : Array<Array<Field>>){
		if(index == 81) return true; //koniec planszy
		if(board[Std.int(index/9)][index%9].value == 0){
			for (i in 1...10) { //sprawdzanie wszystkich możliwych wartości, 1-9
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
	//funkcja resetująca planszę w celu ponownego wprowadzenia danych
	public function reset(e : MouseEvent){
		for (y in 0...9) {
			for (x in 0...9) {
				board[y][x].value = 0;
				board[y][x].update();
			}
		}
	}
	//funkcja sterująca układaniem planszy, wywołaniem rekurencyjnej metody solve, oraz w przypadku braku rozwiązania wyświetlająca odpowiedni komunikat
	public function start(e : MouseEvent){
		//var start = flash.Lib.getTimer(); //*
		if(!boardIsOk(board)){
			unsolvable.visible = true;
		}
		if(solve(0, board)){
			for (y in 0...9) {
				for (x in 0...9) {
					board[y][x].update();
				}
			}
			} else {
				unsolvable.visible = true;
			}
		//trace(flash.Lib.getTimer() - start); //* funkcja do pomiaru czasu trwania algorytmu
	}
	//funkcja sterująca zmianą wartości pól poprzez naciskanie ich
	public function mouseDown(e : MouseEvent){
		if(unsolvable.visible){ //zamykanie komunikatu o braku rozwiązania
			unsolvable.visible = false;
		} else {
			if(e.stageX <= 720 && e.stageY <= 720){ //zapobiegnięcie wyjściu poza tablicę
				board[Std.int(e.stageY/80)][Std.int(e.stageX/80)].value++; //inkrementacja wartości naciśniętego pola
				board[Std.int(e.stageY/80)][Std.int(e.stageX/80)].update();	//narysowanie go ponownie
			}
		}	
	}
	var board : Array<Array<Field>>; //dwuwymiarowa tablica przechowująca pola sudoku
	var unsolvable : TextField; //napis oznajmujący brak rozwiązania
	public function new():Void {
		super();
		
		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);//dodanie "słuchacza" do programu
		board = new Array<Array<Field>>(); //inicjalizacja tablicy
		for (y in 0...9) {
			board[y] = new Array<Field>(); //inicjalizacja drugiego wymiaru tablicy
			for (x in 0...9) {
				board[y][x] = new Field(x*80, y*80, 80, 0); //utworzenie nowego pola
				addChild(board[y][x]); //dodanie pola do Sprite
			}
		}
		addChild(new Grid()); //dodanie nowych lini do Sprite
		{ //tekst o braku rozwiązania
			unsolvable = new TextField();
			unsolvable.width = 320;
			unsolvable.height = 65;
			unsolvable.x = 360 - unsolvable.width / 2;
			unsolvable.y = 325;
			unsolvable.selectable = false;
			var format = new TextFormat(50, TextFormatAlign.CENTER);
			unsolvable.defaultTextFormat = format;
			unsolvable.background = true;
			unsolvable.backgroundColor = 0xffffff;
			unsolvable.border = true;
			unsolvable.borderColor = 0x000000;
			unsolvable.text = "unsolvable";
			addChild(unsolvable);
			unsolvable.visible = false;
		}
		{ //przycisk "Reset"
			var button = new Sprite();
			button.x = 0;
			button.y = 720;

			button.graphics.beginFill(0xFFFFFF); //rysowanie
			button.graphics.drawRect(0, 0, 360, 80);
			button.graphics.endFill();
			button.graphics.lineStyle(3, 0x000000);
			button.graphics.drawRect(0, 0, 360, 80);

			var text = new TextField(); //pole tekstowe
			text.width = 360;
			text.selectable = false;
			
			var format = new TextFormat(50, TextFormatAlign.CENTER);		
			text.defaultTextFormat = format;
			text.text = "Reset";
			button.addEventListener(MouseEvent.CLICK, reset); //dodanie kolejnego "słuchacza" do Sprite
			button.addChild(text); //dodanie pola tekstowego do Sprite
			addChild(button); 
		}
		{ //przycisk "Solve"
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
			addChild(button);
		}
	} 
}