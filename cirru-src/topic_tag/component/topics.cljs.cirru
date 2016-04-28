
ns topic-tag.component.topics $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span button
  [] topic-tag.style.widget :as widget
  [] topic-tag.component.topic-entry :refer $ [] component-topic-entry

defn handle-add (simple-event dispatch)
  dispatch :state/route :add-topic

defn render (topics)
  fn (state mutate)
    div
      {} :style $ {} (:width |400px)
        :min-height |400px
        :background-color $ hsl 0 0 100
      div ({} :style widget/toolbar)
        button $ {} :style widget/button :event ({} :click handle-add)
          , :attrs
          {} :inner-text "|Add topic"

      div ({})
        ->> topics
          map $ fn (topic)
            [] (:id topic)
              component-topic-entry topic

          into $ sorted-map

def component-topics $ create-comp :topics render
