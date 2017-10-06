function MessageLog(props) {
  let messages = props.messages.map(function(m, idx) {
    let direction = m.sender_id === props.userId ? 'outbound' : 'inbound'
    return <Message body={m.body} key={idx} direction={direction} />
  })

  if(props.conversationId !== null) {
    let url = "/api/v1/users/" + props.userId + "/conversations/" + props.conversationId + "/messages"
    return ( 
      <div className='col-sm-9 message-log'>
        {messages}
        <ChatInput handleSubmit={props.handleSubmit}/>
      </div>
    );
  } else {
    return (
      <div className='col-sm-9 message-log'>
      </div>
    )
  }
  
}
