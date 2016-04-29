
ns topic-tag.component.topic-entry $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] topic-tag.component.tag-select :refer $ [] component-tag-select
  [] topic-tag.component.space :refer $ [] component-space

defn handle-click (topic)
  fn (simple-event dispatch)
    dispatch :state/route $ [] :chat-room (:id topic)

defn handle-select (tag)
  fn (simple-event dispatch)
    dispatch :state/route $ [] :topics (:id tag)

defn render (topic)
  fn (state mutate)
    div
      {} :style
        {} (:padding "|6px 16px")
          :border-bottom $ str "|1px solid "
            hsl 0 0 90
          :line-height 2
          :cursor |pointer

        , :event
        {} :click $ handle-click topic

      span $ {} :attrs
        {} :inner-text $ :text topic
      component-space |16px nil
      div
        {} :style $ {} (:display |inline-block)
        ->> (:tags topic)
          map $ fn (tag)
            [] (:id tag)
              component-tag-select tag $ handle-select tag

          into $ sorted-map

def component-topic-entry $ create-comp :topic-entry render
