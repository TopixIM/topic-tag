
ns topic-tag.component.members-overview $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] topic-tag.component.user :refer $ [] component-user

defn render (users)
  fn (state mutate)
    div
      {} :style $ {} (:width |100%)
        :height |100%
        :background-color $ hsl 0 0 100
        :padding |16px
      ->> users
        map-indexed $ fn (index user)
          [] index $ component-user user
        into $ sorted-map

def component-members-overview $ create-comp :members-overview render