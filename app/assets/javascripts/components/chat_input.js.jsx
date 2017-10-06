function ChatInput(props) {
  return (
    <form className="chat-form" method="post" action={props.url}>
      <input type="text" name="body" id="body"/>
    </form>
  )
}