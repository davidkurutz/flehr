function ConversationsColumn(props) {
  conversations = props.conversations.map(function(c, idx) {
    let other = c.recipient.username === props.username ? c.sender.username : c.recipient.username;
    let activeClass = +c.id === +props.conversationId ? 'active': '';
    let alertClass = +c.id === +props.messageAlertId ? 'new-message-alert': '';
    let className = activeClass ? activeClass + ' ' + alertClass : alertClass;

    return (<Conversation
              id={c.id}
              key={idx}
              body={c.body}
              recipient={other}
              onConversationClicked={props.onConversationClicked}
              receiveMessage={props.receiveMessage}
              className={className}
            />)
  })

  return ( 
    <div className='col-sm-3 conversations-column'>
      {conversations}
      <NewConversationForm users={props.users} createConversation={props.createConversation}/>
    </div>
  ); 
}
