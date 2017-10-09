class ChatInput extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    $("input").focus();
  }

  componentWillReceiveProps() {
    $("input").focus();
  }

  render() {
    const placeholder = "Chat with " + this.props.messageRecipient + "...";

    return (
      <form onSubmit={this.props.submitMessage} className="chat-form" method="post" action="#">
        <input type="text" name="body" id="body" placeholder={placeholder} />
      </form>
    );
  }
}
