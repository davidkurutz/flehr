class Conversation extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    const room = "MessagesForConversation" + this.props.id;

    App.cable.subscriptions.create({ channel: "MessagesChannel", room: room }, {
      received: function(data) {
        this.props.receiveMessage(data);
      }.bind(this)
    });
  }

  render() {
    const classString = "conversation" + " " + this.props.className;

    return (
      <div
        className={classString}
        data-id={this.props.id}
        onClick={this.props.onConversationClicked}>{this.props.recipient}
      </div>
    );
  }
}

