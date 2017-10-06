function ConversationsColumn(props) {
  conversations = props.conversations.map(function(c, idx) {
    let other = c.recipient.username === props.username ? c.sender.username : c.recipient.username
    return <Conversation id={c.id} key={idx} body={c.body} recipient={other} onConversationClicked={props.onConversationClicked} />
  })

  return ( 
    <div className='col-sm-3 conversations-column'>
      {conversations}
    </div>
  ); 
}
