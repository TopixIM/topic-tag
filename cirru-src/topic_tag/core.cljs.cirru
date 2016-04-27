
ns topic-tag.core
  :require-macros $ [] cljs.core.async.macros :refer ([] go)
  :require
    [] differ.core :as differ
    [] devtools.core :as devtools
    [] topic-tag.util.websocket :as ws-client
    [] clojure.string :as string
    [] respo.controller.deliver :refer $ [] build-deliver-event mutate-factory
    [] respo.renderer.expander :refer $ [] render-app
    [] respo.renderer.differ :refer $ [] find-element-diffs
    [] respo.util.format :refer $ [] purify-element
    [] respo-client.controller.client :refer $ [] initialize-instance activate-instance patch-instance
    [] topic-tag.component.container :refer $ [] component-container

defonce global-store $ atom ({})

defonce global-states $ atom ({})

defonce global-element $ atom nil

defn get-root ()
  .querySelector js/document |#app

defn dispatch (op op-data)
  go $ >! ws-client/send-chan ([] op op-data)

def build-mutate $ mutate-factory global-element global-states

defn render-element ()
  -- .info js/console |rendering @global-store @global-states
  render-app (component-container @global-store)
    , @global-states build-mutate

defn mount-app ()
  let
    (element $ render-element)
      deliver-event $ build-deliver-event global-element dispatch
    .log js/console |element element
    initialize-instance (get-root)
      , deliver-event
    activate-instance (purify-element element)
      get-root
      , deliver-event
    reset! global-element element

defn rerender-app ()
  let
    (element $ render-element)
      deliver-event $ build-deliver-event global-element dispatch
      changes $ find-element-diffs ([])
        []
        purify-element @global-element
        purify-element element

    -- .info js/console "|DOM changes:" changes
    patch-instance changes (get-root)
      , deliver-event
    reset! global-element element

defn listen-store-changes ()
  go $ loop ([])
    let
      (changes $ <! ws-client/receive-chan)
      reset! global-store $ differ/patch @global-store changes
      -- .info js/console |∆ changes
      -- .info js/console "|new store" @global-store
      rerender-app
      recur

defn -main ()
  devtools/install!
  .log js/console "|started app"
  listen-store-changes
  mount-app
  add-watch global-store :rerender rerender-app
  add-watch global-states :rerender rerender-app

set! js/window.onload -main

defn on-jsload ()
  .log js/console "|should reload..."
  rerender-app
