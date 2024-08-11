* When an action is taken by the user it should update take effect immediately on the Frontend model.
* But the ultimate source of truth should be the backend model. The frontend will attempt to save to the backend after it changes, and usually this update should be smooth and successful.
* When the user goes idle

## Lost connection
We could do something like gmail does when it loses connection:
![[Screenshot by Dropbox Capture.png]]
This is in case the backend goes down we don't want our clients to ddos it.