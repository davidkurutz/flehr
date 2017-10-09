function MessageLog(props) {
  const messages = props.messages.map(function(m, idx) {
    const direction = m.sender_id === props.userId ? "outbound" : "inbound";

    return <Message body={m.body} key={idx} direction={direction} />;
  });

  if (props.conversationId !== null) {
    return (
      <div className="messages col-sm-9">
        <div className="message-log">
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
      <div className="messages col-sm-9">
        <div className="message-log">
        </div>
      </div>
    );
  }
}
