import globals;
import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.path;
import std.string;

class Scoreboard(T)
{
  struct Record
  {
    T points;
    string name;
  }

  @property string fileName() { return _fileName; }
  @property string fullPath() { return _fullPath; }
  @property Record[] records() { return _records; }

  this(string fileName)
  {
    _fileName = fileName;
    _fullPath = buildPath(appSettings.armagetronad.varDir, fileName);
    parseRecords();
  }

private:
  string _fileName;
  string _fullPath;
  Record[] _records;

  void parseRecords()
  {
    _records = std.file.readText(_fullPath)
      .splitLines
      .map!(line => parseRecordLine(line))
      .array;
  }

  Record parseRecordLine(string line)
  {
    // first 9 chars = points
    auto points = line[0..9].strip;
    // rest = name
    auto name = line[9..$];

    return Record(points.to!T, name);
  }
}
