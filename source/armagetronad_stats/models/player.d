import globals;
import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.path;
import std.string;

class Player
{
  @property string name() { return _name; }
  @property void name(string name) { _name = name; }
  @property bool alive() { return _alive; }
  @property void alive(bool alive) { _alive = alive; }
  @property int score() { return _score; }
  @property void score(int score) { _score = score; }
  @property int ping() { return _ping; }
  @property void ping(int ping) { _ping = ping; }
  @property string team() { return _team; }
  @property void team(string team) { _team = team; }

  this(string line)
  {
    if (line.length < 37) { throw new Exception("line length must be > 37"); }
    _name  = line[0..15].strip;
    _alive = line[16..19].strip == "Yes";
    _score = line[23..29].strip.to!int;
    _ping  = line[30..35].strip.to!int;
    _team  = line[36..$].strip;
  }

private:
  string _name;
  bool _alive;
  int _score;
  int _ping;
  string _team;
}
