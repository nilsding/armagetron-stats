module armagetronad_stats.routes;

import armagetronad_stats.controllers;

import vibe.vibe;

URLRouter routes()
{
  auto router = new URLRouter;

  router.registerWebInterface(new StaticController);
  router.registerWebInterface(new LeaderboardController);

  router.get("*", serveStaticFiles("./public"));

  return router;
}
