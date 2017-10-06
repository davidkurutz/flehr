function ChatInput(props) {
  let placeholder = "Chat with " + props.messageRecipient + "...";
  return (
    <form onSubmit={props.handleSubmit} className="chat-form" method="post" action="#">
      <input type="text" name="body" id="body" placeholder={placeholder} />
    </form>
  )
}