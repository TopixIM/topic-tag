
ns topic-tag.util.websocket
  :require-macros $ [] cljs.core.async.macros :refer ([] go)
  :require
    [] cljs.reader :as reader
    [] cljs.core.async :as a :refer $ [] >! <! chan timeout

defonce send-chan $ chan

defonce receive-chan $ chan

defonce ws $ new js/WebSocket |ws://frp.im:4010

enable-console-print!

set! (.-onopen ws)
  fn ()
    println "|socket opened"

set! (.-onmessage ws)
  fn (event)
    let
      (changes $ reader/read-string (.-data event))

      go $ >! receive-chan changes

set! (.-onclose ws)
  fn (event)
    .error js/console "|socket is broken"
    go
      <! $ timeout 6000
      .reload js/location

go $ loop ([])
  .send ws $ pr-str (<! send-chan)
  recur
