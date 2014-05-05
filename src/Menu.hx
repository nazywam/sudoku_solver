import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.events.MouseEvent;

//klasa pełniąca rolę tutułu głównego
class Menu extends flash.display.Sprite {
	var current : flash.display.MovieClip;

	public function new(){
		super();	

		current  = flash.Lib.current;
		current.stage.addEventListener(MouseEvent.CLICK, clicked); //dodanie "słuchacza"

		var text = new TextField(); 
		text.width = 720;
		text.height = 720;
		var format = new TextFormat();
		format.size = 30;
		format.align = TextFormatAlign.CENTER;
		text.selectable = false;
		text.defaultTextFormat = format;

		text.text = "\nSudoku Solver\n\n\n Click on a field to increase its value\n\n\nClick to continue";
		text.textColor = 0xffffff;
		current.addChild(text);

    }
    public function clicked(e : MouseEvent){ //funkcja wywołana przez naciśnięcie 

    	var game = new Game(); //nowy obiekt Game
		current.addChild(game);	
		current.stage.removeEventListener( MouseEvent.CLICK, clicked); //usunięcie inicjalizacji nowych obiektów Game

    }

}