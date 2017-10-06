class ChatApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      users: [],
      conversations: [],
      messages: [],
      conversationId: null
    }
    this.showConversation = this.showConversation.bind(this)
  }

  showConversation(e) {
    let conversationId = ($(e.target).attr('data-id'));
    $.getJSON("/api/v1/users/" + this.props.userId + "/conversations/" + conversationId, (response) => { 
      this.setState({ messages: response.messages, conversationId: +conversationId})
    })
  };

  componentDidMount() {
    $.getJSON('/api/v1/users', (response) => { this.setState({ users: response }) })
    $.getJSON("/api/v1/users/" + this.props.userId + "/conversations", (response) => { this.setState({ conversations: response }) })
  }

  render() {
    return ( 
      <div className="main container">
        <div className="row header">
          <h5>Logged in as {this.props.username}</h5>
        </div>
        <div className="row full-height">
          <ConversationsColumn username={this.props.username} conversations={this.state.conversations} onConversationClicked={this.showConversation}/>
          <MessageLog messages={this.state.messages} userId={this.props.userId} conversationId={this.state.conversationId}/>
        </div>
      </div>
    ); 
  }
}
