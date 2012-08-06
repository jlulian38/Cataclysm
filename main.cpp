/* Main Loop for cataclysm
 * Linux only I guess
 * But maybe not
 * Who knows
 */

#include "catacurses.h"

#include <ctime>
#include "game.h"
#include "color.h"

int main(int argc, char *argv[])
{
  try
  {
     srand(time(NULL));

    // ncurses stuff
     if (!initscr()) // Initialize ncurses
         return -1;
     noecho();  // Don't echo keypresses
     cbreak();  // C-style breaks (e.g. ^C to SIGINT)
     keypad(stdscr, true); // Numpad is numbers
     init_colors(); // See color.cpp
     curs_set(0); // Invisible cursor

     rand();  // For some reason a call to rand() seems to be necessary to avoid
              // repetion.
     bool quit_game = false;
     game *g;
     do {
      g = new game();
        while (!g->do_turn());
        if (g->game_quit())
         quit_game = true;
      delete g;
     } while (!quit_game);
     erase(); // Clear screen
     endwin(); // End ncurses
     system("clear"); // Tell the terminal to clear itself
  }
  catch (TerminationException ex)
  {
  }
 return 0;
}

