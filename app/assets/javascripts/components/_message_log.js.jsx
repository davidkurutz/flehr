function MessageLog(props) {
  let messages = props.messages.map(function(m, idx) {
    let direction = m.sender_id === props.userId ? 'outbound' : 'inbound'
    return <Message body={m.body} key={idx} direction={direction} />
  })

  if(props.conversationId !== null) {
    let url = "/api/v1/users/" + props.userId + "/conversations/" + props.conversationId + "/messages"
    return ( 
      <div className='messages col-sm-9'>
        <div className='message-log'>
          {messages}
        </div>
        <ChatInput 
          submitMessage={props.submitMessage}
          messageRecipient={props.messageRecipient}
        />
      </div>
    );
  } else {
    return (
      <div className='messages col-sm-9'>
        <div className='message-log'>
        </div>
      </div>
    )
  }
  
}
