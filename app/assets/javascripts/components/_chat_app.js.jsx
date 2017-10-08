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
    this.handleSubmit = this.handleSubmit.bind(this)
    this.appendMessage = this.appendMessage.bind(this)
    this.createConversation = this.createConversation.bind(this)
    this.appendConversation = this.appendConversation.bind(this)
    this.filteredUsers = this.filteredUsers.bind(this)
    this.scrollChat = this.scrollChat.bind(this)
  }

  createConversation(e) {
    e.preventDefault()
    let data = $(e.target).serialize();
    $.post(this.conversationsURL(), data, this.appendConversation)
  }

  appendConversation(json) {
    let conversations = this.state.conversations;
    conversations.push(json.data);
    this.setState({ 
      conversations: conversations,
      conversationId: json.data.id,
      messageRecipient: json.data.recipient.username,
      messages: []
    })
  }

  filteredUsers(username) {
    let convoUsers = this.state.conversations.map(function(convo) {
      return [convo.recipient.username, convo.sender.username]
    });

    let excludedUsers = $.map(convoUsers, function(n) {
      return n
    })

    return this.state.users.filter(function(user) {
      return excludedUsers.indexOf(user.username) === -1 && user.username !== username;
    })
  }

  showConversation(e) {
    let conversationId = ($(e.target).attr('data-id'));
    let username = $(e.target).html()
    $.getJSON(this.conversationsURL(conversationId), (response) => { 
      this.setState({
        messages: response.data.messages,
        conversationId: +conversationId,
        messageRecipient: username 
      })
    })
  };

  componentDidMount() {
    $.getJSON(this.usersURL(), (response) => { this.setState({ users: response.data }) })
    $.getJSON(this.conversationsURL(), (response) => { this.setState({ conversations: response.data }) })
  }

  handleSubmit(e) {
    e.preventDefault();
    let data = $(e.target).serialize()
    let url = this.conversationsURL(this.state.conversationId) + "/messages"
    $.post(url, data, this.appendMessage)
    $(e.target)[0].reset();
  }

  appendMessage(json) {
    let messages = this.state.messages
    messages.push(json.data)
    this.setState({ messages: messages });
    this.scrollChat()
  }

  usersURL(id) {
    let url =  "/api/v1/users"
    if (id) {
      url += "/" + id
    }
    return url
  }

  conversationsURL(id) {
    let url = this.usersURL(this.props.userId) + "/conversations";
    if (id) {
      url += "/" + id
    }
    return url
  }

  scrollChat() {
    let messageLog = $('.message-log')[0]
    messageLog.scrollTop = messageLog.scrollHeight - messageLog.clientHeight;
  }

  render() {
    let users = this.filteredUsers(this.props.username)
    return ( 
      <div className="main2 container">
        <div className="row header">
          <h5>Logged in as {this.props.username}</h5>
          <LogOutButton />
        </div>
        <div className="row full-height">
          <ConversationsColumn
            username={this.props.username}
            users={users}
            conversations={this.state.conversations}
            onConversationClicked={this.showConversation}
            conversationId={this.state.conversationId}
            createConversation={this.createConversation}
          />
          <MessageLog
            handleSubmit={this.handleSubmit}
            messages={this.state.messages}
            userId={this.props.userId} 
            conversationId={this.state.conversationId}
            messageRecipient={this.state.messageRecipient}
          />
        </div>
      </div>
    ); 
  }
}
