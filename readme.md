## Note on quality

This is not production quality.  It's not likely to be bug free.  The user interface is to edit the code.  Keep your expectations low.

## Simulation assumptions

This simulation assumes:
- Any given fight is equally likely during the fight phase (same /w challenges)
- The first fight in a run does not affect the probabilities of future fights.  Eg, getting 'Compugilist' on your first fight does not make it less likely to get 'Compugilist' on subsequent fights of the same run.
- I typed up the data correctly
- You want to always go the same ladder direction.
- You're only working the second floor.

## How to run

`ruby crimbot.rb` will run the program.  It should spit out the average number of items acquired.

At the bottom of crimbot.rb, you'll find the actual code that's running.  Modify `runs` to change the number of bot runs to simulate.  Modify `bot = Bot.new` to change the parts in use.  Change the second parameter of `Adventure.new` to `false` in order to always choose 'down' on the ladder choice.  Always goes up otherwise.  Uncomment the `puts s` line in the `log(s)` function to enable debug logging (and see what happens each fight).

