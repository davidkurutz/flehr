function ChatInput(props) {
  return (
    <form onSubmit={props.handleSubmit} className="chat-form" method="post" action="#">
      <input type="text" name="body" id="body"/>
    </form>
  )
}