function ConversationsColumn(props) {
  conversations = props.conversations.map(function(c, idx) {
    let other = c.recipient.username === props.username ? c.sender.username : c.recipient.username
    let activeClass = +c.id === +props.conversationId ? 'active': ''
    return (<Conversation
              id={c.id}
              key={idx}
              body={c.body}
              recipient={other}
              onConversationClicked={props.onConversationClicked}
              className={activeClass}
            />)
  })

  return ( 
    <div className='col-sm-3 conversations-column'>
      {conversations}
      <NewConversationForm users={props.users} createConversation={props.createConversation}/>
    </div>
  ); 
}
