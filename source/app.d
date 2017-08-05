import vibe.vibe;

import config;
import globals;
import armagetronad_stats.routes;

int main()
{
  logInfo("armagetron-stats starting up");

  appSettings = loadConfig();
  if (!appSettings.valid)
  {
    return 1;
  }

  auto settings = new HTTPServerSettings;
  settings.port = appSettings.http.port;
  settings.bindAddresses = appSettings.http.bind;
  listenHTTP(settings, routes);

  return runApplication();
}
