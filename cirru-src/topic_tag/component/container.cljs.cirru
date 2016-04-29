
ns topic-tag.component.container $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] topic-tag.component.sidebar :refer $ [] component-sidebar
  [] topic-tag.component.login :refer $ [] component-login
  [] topic-tag.component.tags-manager :refer $ [] component-tags-manager
  [] topic-tag.component.profile :refer $ [] component-profile
  [] topic-tag.component.topics :refer $ [] component-topics
  [] topic-tag.component.chat-room :refer $ [] component-chat-room
  [] topic-tag.component.topic-editor :refer $ [] component-topic-editor
  [] topic-tag.component.tags-overview :refer $ [] component-tags-overview
  [] topic-tag.component.members-overview :refer $ [] component-members-overview
  [] topic-tag.component.notification-center :refer $ [] comp-notification-center

def style-layout $ {} (:width |100%)
  :height |100%
  :position |absolute
  :display |flex

def style-sidebar $ {}
  :background-color $ hsl 0 0 96
  :width |300px

defn render-store (store)
  div
    {} :style $ {} (:position |absolute)
      :width |400px
      :height |300px
      :background $ hsl 0 0 10 0.24
      :color |white
      :right |0px
      :top |100px
      :font-family |Menlo
      :padding |4px
      :font-size |12px
      :line-height |1.5em
      :overflow |auto
      :pointer-events |none
    span $ {} :attrs
      {} :inner-text $ pr-str (:state store)

def style-container $ {}
  :background-color $ hsl 200 70 90
  :flex 1
  :display |flex
  :justify-content |center
  :align-items |center

defn render (store)
  fn (state mutate)
    let
      (session $ :state store)
        logged-in? $ some? (:user-id session)
        router $ :router session
        live-users $ :live-users store

      if logged-in?
        div ({} :style style-layout)
          div ({} :style style-sidebar)
            component-sidebar (first router)
              count live-users

          div ({} :style style-container)
            case (first router)
              :my-tags $ let
                (tags $ :my-tags store)
                  results $ :tags (:results session)

                component-tags-manager tags results

              :profile $ component-profile (:user store)
              :topics $ component-topics (:topics store)
              :my-topics $ component-topics (:my-topics store)
              :add-topic $ let
                (results $ :tags (:results session))

                component-topic-editor nil results

              :topic-editor $ let
                (topic-data $ get router 1)
                  results $ :tags (:results session)

                component-topic-editor topic-data results

              :chat-room $ component-chat-room (:current-topic store)
                :buffers store
              :all-tags $ component-tags-overview (:tags store)
              :live-users $ component-members-overview live-users
              , nil

          render-store store
          comp-notification-center $ :notifications session

        div
          {} :style $ {} (:display |flex)
            :justify-content |center
            :align-items |center
            :position |absolute
            :width |100%
            :height |100%
            :background-color $ hsl 200 90 70
          component-login
          comp-notification-center $ :notifications session

def component-container $ create-comp :container render
