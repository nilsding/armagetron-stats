import globals;
import vibe.vibe;

import armagetronad_stats.models;

@path("/leaderboard")
class LeaderboardController
{
  void index()
  {
    auto highscores = new Scoreboard!int("highscores.txt");
    auto ladder = new Scoreboard!double("ladder.txt");
    auto wonMatches = new Scoreboard!int("won_matches.txt");
    auto wonRounds = new Scoreboard!int("won_rounds.txt");
    render!("leaderboard/index.dt", appSettings,
            highscores, ladder, wonMatches, wonRounds);
  }
}
