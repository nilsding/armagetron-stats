import globals;
import vibe.vibe;

import armagetronad_stats.models;

class StaticController
{
  void index()
  {
    auto onlinePlayers = new OnlinePlayers();
    render!("static/index.dt", appSettings, onlinePlayers);
  }

  void getAbout()
  {
    render!("static/about.dt", appSettings);
  }
}
