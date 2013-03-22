#include<iostream>

using namespace std;


bool checkFromFirst(int* fromFirstToNinth)
{
  for (int x=1; x<10; x++)
  {
      if (fromFirstToNinth[x]>1)
      {
	for (int erase =0; erase<10; erase++)
	{
	  fromFirstToNinth[erase]=0;
	}
	return 0;
      }
  }
  
  for (int erase =0; erase<10; erase++)
  {
	  fromFirstToNinth[erase]=0;
  }
  return 1;
}
bool checkBoard(int** board)
{
    int* fromFirstToNinth = new int [10];
    
    for (int x = 0; x<9; x++)
    {
	for (int y=0; y<9; y++)
	{
	    fromFirstToNinth[board[y][x]]++;
	}
	if (!checkFromFirst(fromFirstToNinth))
	{
	//  cout << "Vertical error\n";
	  return 0;
	}
	  
    }
    
    for (int y = 0; y<9; y++)
    {
	for (int x=0; x<9; x++)
	{
	    fromFirstToNinth[board[y][x]]++;
	}
	if (!checkFromFirst(fromFirstToNinth))
	{
	//  cout << "Horizontal error\n";
	  return 0;
	}
    } 
    
    for (int block_x=0; block_x<3; block_x++)
    {
      for (int block_y=0; block_y<3; block_y++)
      {
	 for (int x=0; x<3; x++)
	 {
	   for (int y=0; y<3; y++)
	   {
	      fromFirstToNinth[board[block_y*3+y][block_x*3+x]]++;   
	   }
	 }
	 if (!checkFromFirst(fromFirstToNinth))
	 {
	 //  cout << "Squares error\n";
	   return 0;
	 }
	   	
      }
    }
    
    
    return 1;
}

bool back(int** board, int x, int y)
{
      if (x>=9)
      {
	x=0; y++;
      }
      if (y>=9) return 1;
      
     // cout << "X= "<< x << " Y= " << y << "\n";
      
      if (board[y][x]!=0)
      {
	return back(board, (x+1), y);
      }
      for (int digit = 1; digit<10; digit++)
      {
	//cout << "Trying "<< digit << "\n";
	board[y][x]=digit;
	if (checkBoard(board))
	{
	   if (back(board, (x+1), y))
	   {
	     return true;
	  }
	
	  
	}
      }
      
      
      
      board[y][x]=0;
      return 0;
  
  
}



int main()
{
  int **board;
  board = new int *[9];
  for(int i = 0; i <9; i++)
  {
    board[i] = new int[9];
  }
  
  
  for (int y=0; y<9; y++)
  {
      for (int x=0; x<9; x++)
      {
	int currNumber;
	cin >> currNumber;
	board[y][x] = currNumber;
      }
  }
  
  if (back(board,0,0))
  {
      cout << "Found Solutions: \n";
    for (int y=0; y<9; y++)
    {
      for (int x=0; x<9; x++)
      {
	cout << board[y][x] << " ";
      }
      cout << "\n";
    }
  }
  else
  {
    cout << "Impossible\n";
  }
  
      
}