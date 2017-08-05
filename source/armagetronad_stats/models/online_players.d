import globals;
import player;

import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.path;
import std.stdio;
import std.string;

class OnlinePlayers
{
  @property string fullPath() { return _fullPath; }
  @property string rawPlayers() { return _rawPlayers; }
  @property Player[] players() { return _players; }

  this()
  {
    _fullPath = buildPath(appSettings.armagetronad.varDir, "players.txt");
    parsePlayers();
  }

private:
  string _fullPath;
  string _rawPlayers;
  Player[] _players;

  void parsePlayers()
  {
    try
    {
      _rawPlayers = std.file.readText(_fullPath).strip;
      auto split = _rawPlayers.splitLines;
      _players = [];
      if (split[0].strip != "Player:         Alive: Score: Ping: Member of Team:")
      {
        return;
      }
      foreach (line; split[1..$])
      {
        _players ~= new Player(line);
      }
    }
    catch (Exception e)
    {
      stderr.writeln("error while reading current players: " ~ e.msg);
      _rawPlayers = "An error occurred while fetching the players";
    }
  }
}
