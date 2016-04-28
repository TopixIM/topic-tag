
(set-env!
 :asset-paths #{"assets"}
 :source-paths #{}
 :resource-paths #{"src"}

 :dev-dependencies '[]
 :dependencies '[[adzerk/boot-cljs          "1.7.170-3"   :scope "provided"]
                 [adzerk/boot-reload        "0.4.6"       :scope "provided"]
                 [mvc-works/boot-html-entry "0.1.1"       :scope "provided"]
                 [cirru/boot-cirru-sepal    "0.1.1"       :scope "provided"]
                 [org.clojure/clojure       "1.8.0"       :scope "test"]
                 [org.clojure/clojurescript "1.8.51"     :scope "test"]
                 [org.clojure/core.async "0.2.374"]
                 [binaryage/devtools        "0.5.2"       :scope "test"]
                 [differ "0.2.2"]
                 [mvc-works/hsl             "0.1.2"]
                 [mvc-works/respo           "0.1.18"]
                 [mvc-works/respo-client    "0.1.11"]])

(require '[adzerk.boot-cljs :refer [cljs]]
         '[adzerk.boot-reload :refer [reload]]
         '[html-entry.core :refer [html-entry]]
         '[cirru-sepal.core :refer [cirru-sepal]])

(def +version+ "0.1.0")

(task-options!
  pom {:project     'Topix/topic-tag
       :version     +version+
       :description "Workflow"
       :url         "https://github.com/Topix/topic-tag"
       :scm         {:url "https://github.com/Topix/topic-tag"}
       :license     {"MIT" "http://opensource.org/licenses/mit-license.php"}})

(set-env! :repositories #(conj % ["clojars" {:url "https://clojars.org/repo/"}]))

(defn html-dsl [data]
  [:html
   [:head
    [:title "Topix - tag"]
    [:link
     {:rel "stylesheet", :type "text/css", :href "style.css"}]
    [:link
     {:rel "icon", :type "image/png", :href "topic-tag.png"}]
    [:style nil "body {margin: 0;}"]
    [:style
     nil
     "body * {box-sizing: border-box; }"]]
    [:script (if (= :build (:env data))
        "window._appConfig = {env: 'build'}"
        "window._appConfig = {env: 'dev'}")]
   [:body [:div#app] [:script {:src "main.js"}]]])

(deftask compile-cirru []
  (cirru-sepal :paths ["cirru-src"]))

(deftask dev []
  (comp
    (html-entry :dsl (html-dsl {:env :dev}) :html-name "index.html")
    (cirru-sepal :paths ["cirru-src"])
    (cirru-sepal :paths ["cirru-src"] :watch true)
    (watch)
    (reload :on-jsload 'topic-tag.core/on-jsload)
    (cljs)
    (target)))

(deftask build-simple []
  (comp
    (cljs)
    (html-entry :dsl (html-dsl {:env :dev}) :html-name "index.html")
    (target)))

(deftask build-advanced []
  (comp
    (cljs :optimizations :advanced)
    (html-entry :dsl (html-dsl {:env :build}) :html-name "index.html")
    (target)))

(deftask rsync []
  (fn [next-task]
    (fn [fileset]
      (sh "rsync" "-r" "target/" "tiye:repo/Topix/topic-tag" "--exclude" "main.out" "--delete")
      (next-task fileset))))

(deftask send-tiye []
  (comp
    (build-advanced)
    (rsync)))

(deftask build []
  (comp
   (pom)
   (jar)
   (install)
   (target)))

(deftask deploy []
  (comp
   (build)
   (push :repo "clojars" :gpg-sign (not (.endsWith +version+ "-SNAPSHOT")))))
