import globals;
import vibe.vibe;

import std.file;
import std.path;

class StaticController
{
  void index()
  {
    string[] onlinePlayers = this.onlinePlayers();
    render!("static/index.dt", appSettings, onlinePlayers);
  }

  void getAbout()
  {
    render!("static/about.dt", appSettings);
  }

private:
  string[] onlinePlayers()
  {
    try
    {
      auto path = buildPath(appSettings.armagetronad.varDir, "players.txt");
      auto players = std.file.readText(path).splitLines;
      if (players[0] == "Nobody online.")
      {
        return [];
      }
      return players;
    }
    catch (Exception e)
    {
      logError("error while reading current players: " ~ e.msg);
    }
    return ["An error occurred while fetching the players"];
  }
}
