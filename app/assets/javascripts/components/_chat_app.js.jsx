class ChatApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      users: [],
      conversations: [],
      messages: [],
      conversationId: null,
      messageAlertId: null
    }
    this.showConversation = this.showConversation.bind(this)
    this.createConversation = this.createConversation.bind(this)
    this.appendConversation = this.appendConversation.bind(this)
    this.receiveConversation = this.receiveConversation.bind(this)
    this.receiveMessage = this.receiveMessage.bind(this)
    this.submitMessage = this.submitMessage.bind(this)
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

  receiveConversation(json) {
    let conversations = this.state.conversations;
    conversations.push(json.data);
    this.setState({ 
      conversations: conversations
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
    let username = $(e.target).html();
    let messageAlertId = +conversationId === this.state.messageAlertId ? null : this.state.messageAlertId
    $.getJSON(this.conversationsURL(conversationId), (response) => { 
      this.setState({
        messages: response.data.messages,
        conversationId: +conversationId,
        messageRecipient: username,
        messageAlertId: messageAlertId
      })
      this.scrollChat()
    })
  };

  componentWillMount() {
    this.App = {};
    let room = "ConversationsForUser" + this.props.userId
    App.cable = ActionCable.createConsumer();
    App.cable.subscriptions.create({channel: 'ConversationsChannel', room: room }, {
      received: function(data) {
        this.receiveConversation(data)
      }.bind(this)
    })
  }

  componentDidMount() {
    $.getJSON(this.usersURL(), (response) => { this.setState({ users: response.data }) })
    $.getJSON(this.conversationsURL(), (response) => { this.setState({ conversations: response.data }) })
  }

  submitMessage(e) {
    e.preventDefault();
    let data = $(e.target).serialize()
    let url = this.conversationsURL(this.state.conversationId) + "/messages"
    $.post(url, data)
    $(e.target)[0].reset();
  }

  receiveMessage(json) {
    if(this.state.conversationId === json.data.conversation_id) {
      let messages = this.state.messages
      messages.push(json.data)
      this.setState({
        messages: messages
      })
      this.scrollChat()
    } else {
      this.setState({ messageAlertId: json.data.conversation_id })
    }
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
        <Header username={this.props.username} />
        <div className="row full-height">
          <ConversationsColumn
            username={this.props.username}
            users={users}
            conversations={this.state.conversations}
            onConversationClicked={this.showConversation}
            conversationId={this.state.conversationId}
            createConversation={this.createConversation}
            receiveMessage={this.receiveMessage}
            messageAlertId={this.state.messageAlertId}
          />
          <MessageLog
            submitMessage={this.submitMessage}
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
