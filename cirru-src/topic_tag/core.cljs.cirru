
ns topic-tag.core
  :require-macros $ [] cljs.core.async.macros :refer ([] go)
  :require
    [] differ.core :as differ
    [] devtools.core :as devtools
    [] topic-tag.util.websocket :as ws-client

defn -main ()
  .log js/console "|nothing yet.."

set! js/window.onload -main

defn on-jsload ()
  .log js/console |anyway...
