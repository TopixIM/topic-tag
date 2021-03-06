
(ns topic-tag.core
  (:require-macros [cljs.core.async.macros :refer [go]])
  (:require [devtools.core :as devtools]
            [clojure.string :as string]
            [topic-tag.component.container :refer [component-container]]
            [cumulo-client.core :refer [send! setup-socket!]]
            [respo.core :refer [render]]))

(defonce global-store (atom {}))

(defonce global-states (atom {}))

(defn get-root [] (.querySelector js/document "#app"))

(defn dispatch [op op-data] (send! op op-data))

(defn render-app []
  (comment .info js/console "rendering" @global-store @global-states)
  (render
    (component-container @global-store)
    (get-root)
    dispatch
    global-states))

(defn -main []
  (devtools/install!)
  (.log js/console "started app")
  (setup-socket! global-store {:url "ws://localhost:4010"})
  (render-app)
  (add-watch global-store :rerender render-app)
  (add-watch global-states :rerender render-app))

(set! js/window.onload -main)

(defn on-jsload [] (.log js/console "code updated...") (render-app))
