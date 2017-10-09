function ConversationsColumn(props) {
  const conversations = props.conversations.map(function(c, idx) {
    const other = c.recipient.username === props.username ? c.sender.username : c.recipient.username;
    const activeClass = +c.id === +props.conversationId ? "active" : "";
    const alertClass = +c.id === +props.messageAlertId ? "new-message-alert" : "";
    const className = activeClass ? activeClass + " " + alertClass : alertClass;

    return (<Conversation
              id={c.id}
              key={idx}
              body={c.body}
              recipient={other}
              onConversationClicked={props.onConversationClicked}
              receiveMessage={props.receiveMessage}
              className={className}
            />);
  });

  return (
    <div className="col-sm-3 conversations-column">
      {conversations}
      <NewConversationForm users={props.users} createConversation={props.createConversation}/>
    </div>
  );
}
