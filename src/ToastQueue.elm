module ToastQueue exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import IdleGame.Views.Utils
import Time
import Types exposing (..)


create : ToastQueue
create =
    []


updateToastQueue : Time.Posix -> ToastQueue -> ToastQueue
updateToastQueue now toasts =
    List.filter (\(ToastQueueItem _ createdAt) -> Time.posixToMillis createdAt + 5000 > Time.posixToMillis now) toasts


addToast : Toast -> Time.Posix -> ToastQueue -> ToastQueue
addToast toast now toasts =
    ToastQueueItem toast now :: toasts


render : (Toast -> Html FrontendMsg) -> ToastQueue -> Html FrontendMsg
render toastToHtml toasts =
    div [ class "toast fixed toast-bottom toast-center", IdleGame.Views.Utils.zIndexes.toastQueue ]
        (List.map (\(ToastQueueItem toast _) -> toastToHtml toast) toasts)
