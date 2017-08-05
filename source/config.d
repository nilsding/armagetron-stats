import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.stdio;
import sdlang;

struct AppSettings
{
  bool valid = false;

  string name;
  string indexText;

  private struct ArmagetronadSettings
  {
    string varDir;
  }
  ArmagetronadSettings armagetronad;

  private struct HttpSettings
  {
    string[] bind;
    ushort port;
  }
  HttpSettings http;
}

AppSettings loadConfig()
{
  string configPath = findConfig();
  string configContents = import("armagetron-stats.defaults.sdl");
  if (configPath !is null)
  {
    configContents = std.file.readText(configPath);
  }
  return parseSettings(configContents);
}

string findConfig(string filename = "armagetron-stats.sdl")
{
  auto dirs = [
    thisExePath.dirName,
    buildPath(thisExePath.dirName, "../etc"),
    "/usr/local/etc",
    "/etc"
  ];
  foreach (dir; dirs)
  {
    auto path = buildPath(dir, filename);
    if (std.file.exists(path))
    {
      stderr.writeln("Using config file " ~ path);
      return path;
    }
  }
  stderr.writeln("No config found, using defaults.");
  return null;
}

AppSettings parseSettings(string content)
{
  AppSettings settings;

  Tag root;

  try
  {
    root = parseSource(content);
  }
  catch (ParseException e)
  {
    stderr.writeln("Could not parse config: " ~ e.msg);
    return settings;
  }

  settings.name = root.getTagValue!string("name");
  settings.indexText = root.getTagValue!string("index-text");

  // parse armagetronad tag
  Tag armagetronad = root.getTag("armagetronad");
  settings.armagetronad.varDir = armagetronad.getTagValue!string("var-dir");

  // parse http tag
  Tag http = root.getTag("http");
  settings.http.bind = http.getTag("bind")
                           .values
                           .filter!(v => v.type == typeid(string))
                           .map!(v => v.get!string)
                           .array;
  settings.http.port = cast(ushort)(http.getTagValue!int("port", 8080));

  settings.valid = true;
  return settings;
}
