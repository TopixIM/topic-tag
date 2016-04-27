
ns topic-tag.core
  :require-macros $ [] cljs.core.async.macros :refer ([] go)
  :require
    [] differ.core :as differ
    [] devtools.core :as devtools
    [] topic-tag.util.websocket :as ws-client

defonce global-store $ atom ({})

defonce global-states $ atom ({})

defn render-page ()
  .log js/console |render...

defn listen-store-changes ()
  go $ loop ([])
    let
      (changes $ <! ws-client/receive-chan)
      reset! global-store $ differ/patch @global-store changes
      .info js/console |∆ changes
      .info js/console "|new store" @global-store
      render-page
      recur

defn -main ()
  devtools/install!
  .log js/console "|started app"
  listen-store-changes
  add-watch global-store :rerender render-page
  add-watch global-states :rerender render-page

set! js/window.onload -main

defn on-jsload ()
  .log js/console "|should reload..."
