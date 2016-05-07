# In consumers.py
from channels import Group

# Connected to websocket.connect
def ws_add(message):
    Group("tweety").add(message.reply_channel)

# Connected to websocket.receive
def ws_message(message):
    Group("tweety").send({
        "text": message.content['text'],
    })

# Connected to websocket.disconnect
def ws_disconnect(message):
    Group("tweety").discard(message.reply_channel)