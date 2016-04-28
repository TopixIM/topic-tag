
ns topic-tag.component.chat-room $ :require
  [] hsl.core :refer $ [] hsl
  [] topic-tag.style.widget :as widget
  [] respo.alias :refer $ [] create-comp div span button input
  [] topic-tag.component.message :refer $ [] component-message

defn init-state (topic)
  , |

defn update-state (state text)
  , text

defn handle-input (mutate state)
  fn (simple-event dispatch)
    mutate $ :value simple-event

defn handle-submit (mutate state)
  fn (simple-event dispatch)
    dispatch :message/create state
    mutate |

defn handle-keydown (mutate state)
  fn (simple-event dispatch)
    if
      = 13 $ :key-code simple-event
      do (dispatch :message/create state)
        mutate |

defn render (topic)
  fn (state mutate)
    div
      {} :style $ {} (:width |100%)
        :height |100%
        :background-color $ hsl 0 0 100
        :display |flex
        :flex-direction |column
      div
        {} :style $ {} (:font-family "|Helvetica Neue")
          :font-size |24px
          :font-weight |lighter
          :padding "|0 16px"
          :line-height 2
        span $ {} :attrs
          {} :inner-text $ :text topic

      div
        {} :style $ {} (:flex 1)
          :display |flex
          :flex-direction |column
          :overflow |auto
          :padding-bottom |400px
        ->> (:messages topic)
          sort $ fn (entry-1 entry-2)
            compare
              :time $ val entry-1
              :time $ val entry-2

          map-indexed $ fn (index entry)
            let
              (message $ val entry)
              [] (:id message)
                div
                  {} :style $ {}
                    :order $ inc index
                  component-message message

          into $ sorted-map

      div
        {} :style $ {} (:display |flex)
        input $ {} :style widget/textbox :event
          {} :input (handle-input mutate state)
            , :keydown
            handle-keydown mutate state
          , :attrs
          {} (:placeholder "|type in here...")
            :value state

        button $ {} :style widget/button :event
          {} :click $ handle-submit mutate state
          , :attrs
          {} :inner-text |Submit

def component-chat-room $ create-comp :chat-room init-state update-state render
