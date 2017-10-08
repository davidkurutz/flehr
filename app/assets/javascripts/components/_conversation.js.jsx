class Conversation extends React.Component {
  constructor(props) {
    super(props);
  }

  componentWillMount() {
    let room = "MessagesForConversation" + this.props.id
    App.cable.subscriptions.create({channel: 'MessagesChannel', room: room }, {
      received: function(data) {
        this.props.receiveMessage(data)
      }.bind(this)
    })
  }

  render() {
    let classString = "conversation" + " " + this.props.className;
    return (
      <div
        className={classString}
        data-id={this.props.id}
        onClick={this.props.onConversationClicked}>{this.props.recipient}
      </div>
    );
  }
}

