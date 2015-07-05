net = require('net');
http = require('http');
login = require('facebook-chat-api');
fs = require('fs');
config_relay = JSON.parse(fs.readFileSync('./config_relay.json', 'utf8'));


module.exports = (robot) ->

  robot.error (err, msg) ->
    console.log err
    console.log msg

  login 'config.json', (err, api) ->
    if err
      console.log err
      return err
  
    api.setOptions listenEvents: true

    api.listen (err, event, stopListening) ->
      console.log 'event from facebook chat:'
      if err
        console.log err
        process.exit()
      if event.type == "message"
        config_relay.chatrooms.forEach (room) ->
          if event.thread_id == room.facebook
            console.log '  -> message at ' + room.title
            api.markAsRead event.thread_id
            robot.messageRoom room.letschat, "<"+event.sender_name+">"+event.body
          return
      if event.type == "event"
        console.log event

      return
      
    robot.hear //, (msg) ->
      if msg.envelope.user.name isnt "facebot" or not msg.envelope.message.text.match(/</) 
        console.log("message from lets-chat:");
        config_relay.chatrooms.forEach (room) ->
          if msg.envelope.room == room.letschat
            console.log '  -> message at ' + room.title
            api.sendMessage "<"+msg.envelope.user.name+"> "+msg.envelope.message.text, room.facebook, (err, obj) ->
              if err
                console.log err
                process.exit()
            return
          return
        return
      return

    robot.error (err, msg) ->
      console.log err
      console.log msg
      process.exit()

    return

